#!/usr/bin/env python3
"""
Convert Claude Code agents to Cursor rules format
"""

import os
import re
from pathlib import Path

def extract_frontmatter(content):
    """Extract YAML frontmatter from markdown content"""
    if not content.startswith('---'):
        return {}

    end_idx = content.find('---', 3)
    if end_idx == -1:
        return {}

    frontmatter_text = content[3:end_idx].strip()

    # Simple parsing of key-value pairs
    frontmatter = {}
    lines = frontmatter_text.split('\n')
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        if ':' in line:
            key, value = line.split(':', 1)
            key = key.strip()
            value = value.strip()

            # Handle multi-line values
            if value.startswith('|'):
                # Multi-line YAML
                multiline_value = []
                i += 1
                while i < len(lines) and not lines[i].strip().startswith(('-', 'name:', 'description:', 'color:', 'tools:')):
                    multiline_value.append(lines[i])
                    i += 1
                value = '\n'.join(multiline_value).strip()
            elif value.startswith('"') and value.endswith('"'):
                value = value[1:-1]
            elif value.startswith("'") and value.endswith("'"):
                value = value[1:-1]

            frontmatter[key] = value
        else:
            i += 1

    return frontmatter

def extract_system_prompt(content):
    """Extract the system prompt content after frontmatter"""
    if not content.startswith('---'):
        return content

    end_idx = content.find('---', 3)
    if end_idx == -1:
        return content

    return content[end_idx + 3:].strip()

def convert_agent_to_cursor_rule(agent_file_path, output_dir):
    """Convert a single agent file to Cursor rule format"""
    with open(agent_file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    frontmatter = extract_frontmatter(content)
    system_prompt = extract_system_prompt(content)

    if not frontmatter.get('name'):
        print(f"Skipping {agent_file_path} - no name in frontmatter")
        return

    agent_name = frontmatter['name']
    description = frontmatter.get('description', '')
    color = frontmatter.get('color', 'blue')
    tools = frontmatter.get('tools', [])

    # Parse description to extract examples and triggers
    triggers = []
    examples = []

    # Extract activation triggers from description
    if 'Use this agent when' in description:
        trigger_text = description.split('Use this agent when')[1].split('Examples:')[0].strip()
        triggers = [line.strip('- ').strip() for line in trigger_text.split('\n') if line.strip().startswith(('-', '*'))]

    # Parse examples
    example_pattern = r'<example>(.*?)</example>'
    examples_raw = re.findall(example_pattern, description, re.DOTALL)

    for example in examples_raw:
        lines = example.strip().split('\n')
        context = ''
        user_query = ''
        assistant_response = ''
        commentary = ''

        for line in lines:
            if line.startswith('Context:'):
                context = line.replace('Context:', '').strip()
            elif line.startswith('user:'):
                user_query = line.replace('user:', '').strip()
            elif line.startswith('assistant:'):
                assistant_response = line.replace('assistant:', '').strip()
            elif line.startswith('<commentary>'):
                commentary = line.replace('<commentary>', '').replace('</commentary>', '').strip()

        examples.append({
            'context': context,
            'user_query': user_query,
            'assistant_response': assistant_response,
            'commentary': commentary
        })

    # Create output path
    output_file = output_dir / f"{agent_name}.md"

    # Generate Cursor rule content
    rule_content = f"""# {agent_name.replace('-', ' ').title()} Agent

## Role Definition
{system_prompt.split('Your primary responsibilities:')[0].strip()}

## Activation Triggers
"""

    if triggers:
        for trigger in triggers:
            rule_content += f"- {trigger}\n"
    else:
        rule_content += "- Agent-specific tasks and expertise areas\n"

    rule_content += "\n## Core Responsibilities\n\n"

    # Extract responsibilities from system prompt
    if 'Your primary responsibilities:' in system_prompt:
        responsibilities_section = system_prompt.split('Your primary responsibilities:')[1]
        if '**Design Principles' in responsibilities_section:
            responsibilities_section = responsibilities_section.split('**Design Principles')[0]

        # Split into numbered items
        numbered_pattern = r'(\d+\.)\s*\*\*([^*]+)\*\*:\s*(.*?)(?=\d+\.|$)'
        matches = re.findall(numbered_pattern, responsibilities_section, re.DOTALL)

        for num, title, content in matches:
            rule_content += f"### {num} {title}\n"
            # Clean up the content
            content = re.sub(r'\n\s*-\s*', '\n- ', content.strip())
            rule_content += f"{content}\n\n"

    rule_content += "## Studio Integration\n"
    rule_content += "- Follow 6-day sprint methodology\n"
    rule_content += "- Balance rapid development with code quality\n"
    rule_content += "- Ensure maintainable solutions\n"
    rule_content += "- Create delightful user experiences\n"

    rule_content += "\n## Example Usage\n"

    for i, example in enumerate(examples[:3]):  # Limit to 3 examples
        rule_content += f"**Example {i+1}:** {example['context']}\n"
        rule_content += f"- **User:** {example['user_query']}\n"
        rule_content += f"- **Approach:** {example['assistant_response']}\n"
        if example['commentary']:
            rule_content += f"- **Rationale:** {example['commentary']}\n"
        rule_content += "\n"

    rule_content += "## Tools Access\n"
    if tools:
        rule_content += "- " + "\n- ".join(tools)
    else:
        rule_content += "- File system operations (read, write, search)\n- Terminal commands\n- Code analysis and modification\n- Web search for research"

    # Write the converted rule
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(rule_content)

    print(f"Converted {agent_name} -> {output_file}")

def main():
    """Convert all agents to Cursor rules format"""
    project_root = Path(__file__).parent.parent
    agents_dir = project_root / "design" / "engineering" / "marketing" / "product" / "project-management" / "studio-operations" / "testing" / "bonus"

    # Find all agent files
    agent_files = []
    for department in ['design', 'engineering', 'marketing', 'product', 'project-management', 'studio-operations', 'testing', 'bonus']:
        dept_dir = project_root / department
        if dept_dir.exists():
            agent_files.extend(dept_dir.glob('*.md'))

    # Create output directory
    output_dir = project_root / ".cursor" / "rules"
    output_dir.mkdir(parents=True, exist_ok=True)

    # Create department subdirectories
    for department in ['design', 'engineering', 'marketing', 'product', 'project-management', 'studio-operations', 'testing', 'bonus']:
        (output_dir / department).mkdir(exist_ok=True)

    # Convert each agent
    converted = 0
    for agent_file in agent_files:
        if agent_file.name in ['ui-designer.md', 'frontend-developer.md', 'backend-architect.md', 'studio-coach.md', 'api-tester.md', 'performance-benchmarker.md', 'test-results-analyzer.md', 'tool-evaluator.md', 'workflow-optimizer.md']:
            # Skip already converted agents
            continue

        # Determine output subdirectory
        dept_name = agent_file.parent.name
        output_dept_dir = output_dir / dept_name

        try:
            convert_agent_to_cursor_rule(agent_file, output_dept_dir)
            converted += 1
        except Exception as e:
            print(f"Error converting {agent_file}: {e}")

    print(f"\nConversion complete! Converted {converted} agents to Cursor rules format.")

if __name__ == '__main__':
    main()
