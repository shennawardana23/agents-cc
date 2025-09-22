#!/usr/bin/env python3
"""
Convert all .md rule files to .mdc format with proper frontmatter
"""

import os
import re
from pathlib import Path

def convert_md_to_mdc(md_file_path, mdc_file_path):
    """Convert a single .md file to .mdc format with frontmatter"""
    with open(md_file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Extract agent name from first line
    lines = content.split('\n')
    if lines and lines[0].startswith('# '):
        agent_name = lines[0][2:].strip()
    else:
        agent_name = md_file_path.stem

    # Create description from agent name
    description = f"{agent_name} - AI agent specialized in specific domain expertise"

    # Create frontmatter
    frontmatter = f"""---
description: {description}
globs: **/*.*
alwaysApply: false
---
"""

    # Write the new .mdc file
    with open(mdc_file_path, 'w', encoding='utf-8') as f:
        f.write(frontmatter + '\n' + content)

    print(f"Converted {md_file_path} -> {mdc_file_path}")

def main():
    """Convert all .md files in rules directory to .mdc format"""
    project_root = Path(__file__).parent.parent
    rules_dir = project_root / ".cursor" / "rules"

    if not rules_dir.exists():
        print(f"Rules directory not found: {rules_dir}")
        return

    converted = 0

    # Find all .md files in rules directory and subdirectories
    for md_file in rules_dir.rglob('*.md'):
        # Skip if corresponding .mdc already exists
        mdc_file = md_file.with_suffix('.mdc')
        if mdc_file.exists():
            continue

        try:
            convert_md_to_mdc(md_file, mdc_file)
            converted += 1
        except Exception as e:
            print(f"Error converting {md_file}: {e}")

    print(f"\nConversion complete! Converted {converted} files to .mdc format.")

if __name__ == '__main__':
    main()
