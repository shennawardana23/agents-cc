# User Rules for AI Agent Interaction

Comprehensive guidelines for interacting with AI agents in the Arcipelago International studio system. These rules ensure effective communication, proper agent activation, and successful collaboration, especially in custom scenarios without attached documentation.

## 🎯 Core Philosophy

### **Agent-First Communication**

- **Clear Intent**: Always express what you want to accomplish before providing details
- **Context-Aware**: Agents should infer missing information from project context and patterns
- **Proactive Assistance**: Agents should ask clarifying questions when requirements are unclear
- **Documentation Independence**: Agents should work effectively even without attached documentation

### **Custom Scenario Handling**

- **Pattern Recognition**: Use existing project patterns to infer requirements
- **Best Practice Application**: Apply established conventions from similar implementations
- **Clarification Seeking**: Ask targeted questions when context is insufficient
- **Progressive Enhancement**: Start with basic implementation and iterate based on feedback

## Agent Interaction Guidelines

### How to Activate Agents

1. **Direct Mention**: Use `@agent-name` followed by your request

   ```markdown
   @ux-researcher, please conduct a user interview for our new feature
   ```

2. **Expertise Description**: Describe what you need without mentioning a specific agent

   ```markdown
   I need help analyzing user feedback and prioritizing features for the next sprint
   ```

3. **Task-Based Requests**: Clearly describe the task and let agents self-select

   ```markdown
   Create a component that allows users to upload and preview images
   ```

4. **Custom Scenario Request**: For complex implementations without documentation

   ```markdown
   I have a complex business logic requirement that needs to integrate with our existing user management system. The current implementation uses JWT tokens and PostgreSQL. Please implement this following our established patterns.
   ```

### Communication Best Practices

- **Be Specific**: Clearly describe what you want to accomplish
- **Provide Context**: Include relevant background information
- **Set Expectations**: Mention deadlines, priorities, or constraints
- **Request Format**: Specify if you need code, documentation, analysis, or research
- **Ask Questions**: If something is unclear, ask for clarification

#### **Custom Scenario Communication**

When working without attached documentation:

1. **Describe Current State**

   ```markdown
   We're building on our existing e-commerce platform that uses:
   - React frontend with TypeScript
   - Go backend with Clean Architecture
   - PostgreSQL database
   - Redis for caching
   ```

2. **Specify Integration Points**

   ```markdown
   This needs to integrate with our existing user authentication system and payment processing module
   ```

3. **Define Success Criteria**

   ```markdown
   The implementation should handle 1000 concurrent users and process transactions within 2 seconds
   ```

4. **Mention Constraints**

   ```markdown
   Must work within our existing error handling patterns and logging system
   ```

## Agent Selection Guidelines

### When to Use Which Agent

#### Design Department

- **UX Researcher**: User research, usability testing, user interviews
- **Visual Storyteller**: Visual design, narrative design, storytelling
- **Brand Guardian**: Brand consistency, visual identity, guidelines
- **Whimsy Injector**: Creative elements, playful design, fun experiences

#### Engineering Department

- **AI Engineer**: AI implementation, machine learning, AI architecture
- **DevOps Automator**: Infrastructure, deployment pipelines, automation
- **Mobile App Builder**: Mobile development, iOS/Android apps
- **Rapid Prototyper**: Quick prototyping, MVP development
- **Test Writer Fixer**: Testing, test automation, quality assurance

#### Marketing Department

- **Growth Hacker**: Growth strategies, user acquisition, optimization
- **Instagram Curator**: Instagram content, social media strategy
- **Reddit Community Builder**: Reddit marketing, community management
- **TikTok Strategist**: TikTok content, short-form video marketing
- **Twitter Engager**: Twitter strategy, social media engagement

#### Product Department

- **Feedback Synthesizer**: User feedback analysis, product improvement
- **Sprint Prioritizer**: Sprint planning, task prioritization
- **Trend Researcher**: Market research, trend analysis, competitive intelligence

#### Project Management Department

- **Experiment Tracker**: A/B testing, experiment management
- **Project Shipper**: Product launches, go-to-market strategy
- **Studio Producer**: Project coordination, team management

#### Studio Operations Department

- **Analytics Reporter**: Data analysis, reporting, metrics
- **Finance Tracker**: Budget management, cost tracking
- **Infrastructure Maintainer**: System maintenance, technical operations
- **Legal Compliance Checker**: Legal compliance, regulatory requirements
- **Support Responder**: Customer support, issue resolution

#### Testing Department

- **API Tester**: API testing, integration testing
- **Performance Benchmarker**: Performance testing, load testing
- **Test Results Analyzer**: Test analysis, quality metrics
- **Tool Evaluator**: Tool assessment, technology evaluation
- **Workflow Optimizer**: Process improvement, optimization

#### Bonus Department

- **Joker**: Tech humor, programming jokes, team morale

## 📋 Agent Selection for Custom Work

### **Expertise Matching for Complex Requirements**

#### **Complex Technical Requirements**

- **AI Engineer**: Advanced algorithms, ML integration, complex data processing
- **DevOps Automator**: Infrastructure, deployment, scaling challenges
- **Test Writer Fixer**: Comprehensive testing strategies, quality assurance

#### **Integration & Architecture**

- **Backend Architect**: API design, database optimization, system integration
- **Mobile App Builder**: Cross-platform compatibility, native features
- **Rapid Prototyper**: Quick implementation, MVP development

#### **User Experience & Interface**

- **UX Researcher**: User flow optimization, interaction design
- **Visual Storyteller**: Information architecture, visual hierarchy
- **Frontend Developer**: Component architecture, responsive design

### **Multi-Agent Coordination**

For complex custom scenarios:

   ```markdown
   @backend-architect and @frontend-developer need to collaborate on implementing a real-time collaborative editing feature for our document management system
   ```

## 🏗️ Custom Implementation Guidelines

### **Pattern Recognition & Application**

When no documentation is provided, agents should:

1. **Analyze Existing Codebase**
   - Review similar implementations in the project
   - Identify established patterns and conventions
   - Use existing utility functions and helpers

2. **Apply Established Standards**
   - Follow project-specific coding conventions
   - Use established architectural patterns
   - Apply consistent error handling approaches

3. **Seek Clarification Proactively**

   ```markdown
   I notice you have several authentication patterns in your codebase. Should I follow the JWT-based approach used in your user management module, or do you have a different preference for this implementation?
   ```

### **Progressive Implementation**

For custom scenarios:

1. **Start with Core Functionality**
   - Implement the basic required functionality
   - Use established patterns and conventions
   - Ensure compatibility with existing systems

2. **Add Enhancement Layers**
   - Include error handling and validation
   - Add logging and monitoring
   - Implement security measures

3. **Provide Implementation Options**
   - Suggest multiple approaches when applicable
   - Explain trade-offs between different solutions
   - Recommend based on project context

## Request Structure

### Effective Request Format

   ```markdown
   **Context**: Brief background about the current situation
   **Goal**: What you want to accomplish
   **Requirements**: Specific needs or constraints
   **Timeline**: When you need this completed
   **Format**: How you want the output (code, documentation, analysis, etc.)
   ```

### **Complete Custom Implementation Template**

   ```markdown
   **Context**: [Brief description of current situation and existing systems]
   **Goal**: [What you want to accomplish]
   **Integration Points**: [How this should connect with existing systems]
   **Technical Requirements**: [Specific technical constraints or preferences]
   **Success Criteria**: [How to measure if implementation is successful]
   **Timeline**: [When you need this completed]
   **Format**: [How you want the output structured]

   **Additional Context**:
   - Current tech stack: [languages, frameworks, databases]
   - Existing patterns: [naming conventions, architectural patterns]
   - Constraints: [performance requirements, security considerations]
   ```

### **Example: Custom E-commerce Feature**

   ```markdown
   **Context**: We're building on our existing e-commerce platform
   **Goal**: Implement a subscription billing system for recurring orders
   **Integration Points**: Needs to work with existing user management and payment processing
   **Technical Requirements**: Use Stripe for payment processing, follow our existing error handling patterns
   **Success Criteria**: Handle 1000+ concurrent subscriptions, process recurring billing accurately
   **Timeline**: Need basic implementation by Friday
   **Format**: Go structs and handlers, React components for admin interface

   **Additional Context**:
   - Backend: Go with Clean Architecture patterns
   - Frontend: React with TypeScript
   - Database: PostgreSQL with existing user and order tables
   - Authentication: JWT-based system already in place
   ```

### Example Requests

#### Good Request Example

   ```markdown
   @mobile-app-builder

   **Context**: We're building a fitness tracking app and need to implement user authentication
   **Goal**: Create a login and registration system for iOS and Android
   **Requirements**: Use Firebase Auth, include email/password and social login
   **Timeline**: Need this by end of sprint (Friday)
   **Format**: Provide React Native components with TypeScript
   ```

#### Research Request Example

   ```markdown
   @trend-researcher

   **Context**: Planning our Q2 product roadmap for the social media analytics tool
   **Goal**: Identify emerging trends in social media analytics
   **Requirements**: Focus on B2B SaaS companies, look at competitors
   **Timeline**: Need insights by Tuesday for planning meeting
   **Format**: Summary report with key findings and recommendations
   ```

## Collaboration Guidelines

### Multi-Agent Coordination

- **Complex Tasks**: Mention multiple agents for combined expertise

   ```markdown
   @ux-researcher and @visual-storyteller need to collaborate on the new user onboarding flow
   ```

- **Project Coordination**: Use studio producer for overall project management

   ```markdown
   @studio-producer, please coordinate the team for the new feature launch
   ```

- **Cross-Departmental Work**: Specify when agents need to work across departments

   ```markdown
   @feedback-synthesizer and @sprint-prioritizer, let's analyze user feedback to plan next sprint
   ```

### Agent-to-Agent Communication

- Agents should communicate clearly when collaborating
- Agents should document their decisions and rationale
- Agents should ask for clarification when needed
- Agents should respect each other's expertise areas

## Quality and Review Standards

### Code Quality Expectations

- **Follow Project Rules**: All code must adhere to project coding standards
- **Test Coverage**: Include appropriate tests for new functionality
- **Documentation**: Provide clear documentation and comments
- **Error Handling**: Implement proper error handling and validation
- **Performance**: Consider performance implications of implementation

### **Custom Work Quality Standards**

- **Pattern Consistency**: Follow established project patterns and conventions
- **Error Handling**: Implement comprehensive error handling using existing patterns
- **Documentation**: Provide clear documentation for complex logic
- **Testing**: Include appropriate tests following project testing standards
- **Performance**: Consider performance implications and optimization opportunities

### **Integration Standards**

- **System Compatibility**: Ensure compatibility with existing systems
- **Data Consistency**: Maintain data integrity across integrated components
- **Security Compliance**: Follow established security practices
- **Monitoring Ready**: Include appropriate logging and monitoring hooks

### Review Process

- **Self-Review**: Agents should review their own work before delivery
- **Testing**: Verify functionality works as expected
- **Documentation**: Ensure all deliverables are properly documented
- **Validation**: Confirm requirements are met

## Feedback and Iteration

### Providing Feedback

- **Be Specific**: Point out exactly what needs to be changed
- **Be Constructive**: Focus on improvements, not criticism
- **Include Examples**: Show preferred alternatives when possible
- **Set Priorities**: Indicate which changes are most important

### Requesting Revisions

   ```markdown
   @agent-name, the previous implementation needs these changes:

   1. **Issue**: The component doesn't handle edge cases properly
   2. **Expected**: Should handle empty states gracefully
   3. **Priority**: High - blocking user testing

   Please revise and provide updated code.
   ```

## Emergency and Urgent Requests

### Priority Levels

- **Critical**: System down, security issues, data loss
- **High**: Blocking development, missed deadlines
- **Medium**: Important but not blocking
- **Low**: Nice to have, future improvements

### Urgent Request Format

   ```markdown
   🚨 URGENT: @agent-name

   **Priority**: Critical
   **Issue**: [Brief description]
   **Impact**: [What happens if not fixed]
   **Timeline**: ASAP / Within 2 hours
   ```

## Documentation and Knowledge Sharing

### What to Document

- **Decisions**: Why certain approaches were chosen
- **Trade-offs**: Alternatives considered and why they were rejected
- **Dependencies**: External systems or services used
- **Future Considerations**: Things to watch out for or improve later

### Documentation Format

- **README Files**: For new features or systems
- **Code Comments**: For complex logic or business rules
- **Architecture Decisions**: For significant technical choices
- **User Guides**: For new workflows or processes

## Communication Style

### Tone and Approach

- **Professional but Friendly**: Maintain professionalism while being approachable
- **Clear and Direct**: Avoid ambiguity in requests and responses
- **Solution-Oriented**: Focus on solving problems rather than assigning blame
- **Collaborative**: Work together as a team

### Language Guidelines

- **Use Simple Language**: Avoid unnecessary jargon
- **Be Concise**: Get to the point without being rude
- **Use Formatting**: Structure requests with headers and bullet points
- **Include Examples**: Show rather than tell when possible

## Best Practices Summary

### For Getting Work Done

1. **Be specific** about what you need
2. **Provide context** about the situation
3. **Set clear expectations** for timeline and format
4. **Use appropriate agents** for the task
5. **Review and provide feedback** on deliverables

### For Complex Projects

1. **Break down large tasks** into smaller, manageable pieces
2. **Coordinate between agents** when multiple expertise areas are needed
3. **Document progress** and decisions along the way
4. **Plan for testing and review** cycles
5. **Celebrate milestones** and completed work

### For Quality Assurance

1. **Test thoroughly** before declaring work complete
2. **Follow coding standards** and best practices
3. **Consider edge cases** and error scenarios
4. **Document assumptions** and limitations
5. **Request feedback** when unsure about approach

## 🚨 Handling Ambiguous Requirements

### **Clarification Protocol**

When requirements are unclear, agents should:

1. **Identify Ambiguities**

   ```markdown
   I want to make sure I understand correctly. You mentioned [specific requirement], but I need clarification on [ambiguous aspect].
   ```

2. **Propose Interpretations**

   ```markdown
   Based on your existing codebase patterns, I assume you want me to follow the [specific pattern] approach. Is that correct?
   ```

3. **Offer Options**

   ```markdown
   I see two possible approaches:
   1. [Option A] - following your existing [pattern]
   2. [Option B] - using [alternative approach]

   Which would you prefer, or do you have a different approach in mind?
   ```

4. **Request Examples**

   ```markdown
   Could you provide an example of how this should work? For instance, what should happen when [specific scenario] occurs?
   ```

## 📚 Documentation for Custom Work

### **Self-Documenting Code**

- **Clear Function Names**: Use descriptive names that explain purpose
- **Comprehensive Comments**: Document complex logic and business rules
- **Usage Examples**: Include examples of how to use the implementation
- **Integration Notes**: Document how it connects with existing systems

### **Implementation Documentation**

```markdown
## Implementation Notes

**Architecture Decision**: Used [pattern] to ensure compatibility with existing [system]

**Integration Points**:
- [System A]: Connected via [method]
- [System B]: Uses existing [API/protocol]

**Usage Example**:
   ```go
   // Example usage
   result, err := customFunction(ctx, params)
   if err != nil {
       // Handle error according to project patterns
   }
   ```

**Future Considerations**:

- May need optimization for high-traffic scenarios
- Consider caching layer for improved performance
- Monitor error rates in production

   ```markdown
   ## 🎯 Best Practices Summary
   ```

### **For Custom Work Requests**

1. **Be Specific**: Clearly describe what you need, even without documentation
2. **Provide Context**: Explain how this fits into existing systems
3. **Set Expectations**: Define success criteria and constraints
4. **Allow Flexibility**: Be open to agent suggestions based on project patterns
5. **Request Clarification**: Ask questions when something is unclear

### **For Complex Custom Projects**

1. **Break Down Tasks**: Divide large custom implementations into manageable pieces
2. **Coordinate Agents**: Use multiple agents when different expertise areas are needed
3. **Document Progress**: Keep track of decisions and implementation details
4. **Plan Integration**: Consider how custom work will integrate with existing systems
5. **Test Thoroughly**: Validate custom implementations against existing patterns

   ```markdown
   @backend-architect and @frontend-developer need to collaborate on implementing a real-time collaborative editing feature for our document management system
   ```

### **For Quality Assurance**

1. **Follow Patterns**: Use established project patterns and conventions
2. **Handle Errors**: Implement comprehensive error handling
3. **Document Decisions**: Explain why certain approaches were chosen
4. **Test Integration**: Ensure compatibility with existing systems
5. **Performance Conscious**: Consider performance implications

This system is designed to be flexible and adaptive while maintaining high quality standards and clear communication.
