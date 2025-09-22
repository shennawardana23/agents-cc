# Project Rules

These rules define the coding standards, project structure, and development practices for the Arcipelago International studio system.

## Code Organization

### Directory Structure

```
/
├── .cursor/                 # Cursor configuration and rules
├── design/                  # Design department agents (original)
├── engineering/            # Engineering department agents (original)
├── marketing/              # Marketing department agents (original)
├── product/                # Product department agents (original)
├── project-management/     # Project management agents (original)
├── studio-operations/      # Studio operations agents (original)
├── testing/                # Testing department agents (original)
├── bonus/                  # Bonus agents (original)
├── src/                    # Main application source code
│   ├── components/         # Reusable UI components
│   │   └── ui/            # Design system components
│   ├── pages/             # Application pages/routes
│   ├── hooks/             # Custom React hooks
│   ├── utils/             # Utility functions
│   ├── types/             # TypeScript type definitions
│   └── styles/            # Global styles and themes
├── public/                # Static assets
├── docs/                  # Documentation
└── tests/                 # Test files
```

### File Naming Conventions

- **Components**: `PascalCase.tsx` (e.g., `UserProfile.tsx`)
- **Hooks**: `useCamelCase.ts` (e.g., `useAuth.ts`)
- **Utils**: `camelCase.ts` (e.g., `formatDate.ts`)
- **Types**: `PascalCase.ts` or `camelCase.ts` (e.g., `User.ts`, `apiTypes.ts`)
- **Styles**: `camelCase.module.css` or `componentName.module.css`
- **Tests**: `componentName.test.tsx` or `utils.test.ts`

## Coding Standards

### React & JSX Best Practices

- Use functional components with hooks instead of class components
- Always use TypeScript for type safety
- Use custom hooks for shared logic
- Implement proper error boundaries
- Use React.memo for performance optimization when needed
- Follow the single responsibility principle for components

### Code Quality

- **ESLint**: Follow all ESLint rules without disabling them
- **Prettier**: Use consistent formatting (2 spaces, single quotes)
- **TypeScript**: Strict mode enabled, no `any` types
- **Imports**: Group imports (React, third-party, internal)
- **Exports**: Use named exports over default exports
- **Constants**: Use UPPER_CASE for constants

### Component Guidelines

- Keep components small and focused
- Use composition over inheritance
- Implement proper prop types
- Use custom hooks for complex logic
- Memoize expensive calculations
- Handle loading and error states

## UI Component Standards

### Design System Components

When building UI, prioritize reusing existing components from `/src/components/ui/`:

```typescript
// ✅ Good: Reuse existing UI components
import { Button, Input, Card } from '@/components/ui'

// ✅ Good: Create new components by orchestrating UI components
const UserForm = () => {
  return (
    <Card>
      <Input placeholder="Name" />
      <Input placeholder="Email" type="email" />
      <Button type="submit">Submit</Button>
    </Card>
  )
}

// ❌ Avoid: Creating new components when existing ones solve the problem
```

### Component Creation Rules

1. **Check existing components first** in `/src/components/ui/`
2. **Orchestrate existing components** to solve new problems
3. **Create new components only** when no existing solution works
4. **Ask the human** if unsure about component creation
5. **Follow design system** patterns and conventions

### Declarative Code Style

- Use declarative programming patterns
- Avoid imperative DOM manipulation
- Prefer CSS-in-JS or styled-components
- Use CSS Grid and Flexbox for layouts
- Implement responsive design principles

## State Management

### Local State

- Use `useState` for simple local state
- Use `useReducer` for complex local state
- Use custom hooks for shared state logic

### Global State

- Use Context API for simple global state
- Consider state management libraries for complex applications
- Keep global state minimal and focused

### Side Effects

- Use `useEffect` for side effects
- Clean up effects properly
- Avoid infinite re-render loops

## Testing Standards

### Test Structure

- Unit tests for individual functions
- Integration tests for component interactions
- E2E tests for critical user flows
- Mock external dependencies appropriately

### Test Coverage

- Aim for 80%+ code coverage
- Test error scenarios and edge cases
- Include accessibility testing
- Test responsive design breakpoints

## Performance Guidelines

### Bundle Optimization

- Use code splitting for large applications
- Implement lazy loading for routes
- Optimize images and assets
- Use tree shaking for unused code

### Runtime Performance

- Memoize expensive computations
- Use virtualization for large lists
- Optimize re-renders with React.memo
- Implement proper loading states

## Security Practices

### Input Validation

- Validate all user inputs
- Sanitize data before processing
- Use parameterized queries for databases
- Implement proper authentication flows

### Data Protection

- Use HTTPS for all communications
- Implement proper CORS policies
- Handle sensitive data securely
- Follow OWASP guidelines

## Documentation Standards

### Code Comments

- Use JSDoc for function documentation
- Comment complex business logic
- Document prop types and interfaces
- Include usage examples

### README Files

- Include setup instructions
- Document API endpoints
- Provide deployment guidelines
- List development dependencies

## Git Workflow

### Branch Naming

- `feature/feature-name`
- `bugfix/issue-description`
- `hotfix/critical-issue`
- `release/version-number`

### Commit Messages

- Use conventional commit format
- Start with imperative mood
- Keep first line under 50 characters
- Reference issue numbers when applicable

### Pull Request Process

- Include description of changes
- Reference related issues
- Add screenshots for UI changes
- Request appropriate reviewers

## Development Workflow

### 6-Day Sprint Methodology

1. **Planning** (Day 1): Define goals and requirements
2. **Design** (Day 1-2): Create mockups and user flows
3. **Development** (Day 2-5): Build and iterate
4. **Testing** (Day 5-6): Quality assurance and bug fixes
5. **Review** (Day 6): Code review and final polish
6. **Ship** (Day 6): Deploy and celebrate

### Code Review Process

- Review for functionality and edge cases
- Check for security vulnerabilities
- Verify accessibility compliance
- Ensure code follows project standards
- Test changes locally when possible

## Tool Usage Guidelines

### When to Use Which Tools

- **Write**: Creating new files and documentation
- **Read**: Examining existing code and files
- **MultiEdit**: Making changes across multiple files
- **Bash**: Running terminal commands and scripts
- **Grep**: Searching for patterns in code
- **Git**: Version control operations
- **Brave Search**: Research and information gathering

### Agent Coordination

- Use appropriate agents for specific tasks
- Coordinate between agents for complex workflows
- Document decisions and rationale
- Maintain clear communication channels

## Quality Gates

### Before Code Review

- All tests pass
- Code builds without errors
- ESLint passes without warnings
- TypeScript compilation succeeds
- Accessibility audit passes

### Before Deployment

- All quality gates pass
- Performance tests complete
- Security scan passes
- Documentation updated
- Backwards compatibility verified

This project follows modern web development best practices while maintaining flexibility for rapid iteration and innovation.
