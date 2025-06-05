# Implementation Guidelines

## Project Context
Refer to [project-context.md](./project-context.md) for an overview of the Hedwig project, its architecture, and key components.

## Testing Guidelines
- ALWAYS run tests to verify implementations before submitting code
- NEVER submit code without having verified it through appropriate tests
- Remember that getting feedback from tests is critical for code quality
- Be aware that Claude cannot directly run tests in the environment - you must manually run tests and provide feedback

## Build and Test Verification

### CRITICAL: Always Use Correct Java Version
- **Check Project Requirements**: Always check `build.gradle` for `sourceCompatibility` and `targetCompatibility` settings
- **Use Correct Java Version**: Set `JAVA_HOME` to match project requirements before running any build commands
- **Example**: For Java 11 projects, use: `JAVA_HOME=/Users/kumarashish/Library/Java/JavaVirtualMachines/corretto-11.0.20.1/Contents/Home`
- **Check Available JVMs**: Use `/usr/libexec/java_home -V` to see all available Java versions

### Mandatory Build and Test Workflow
1. **Clean Build**: Always start with `./gradlew clean` to remove any stale artifacts
2. **Compile Check**: Run `./gradlew compileJava` to verify main code compilation
3. **Test Compilation**: Run `./gradlew compileTestJava` to verify test code compilation
4. **Full Test Suite**: Run `./gradlew test` to execute all tests
5. **Fix All Issues**: Never leave failing tests or compilation errors unresolved

### Common Issues and Solutions
- **Lombok Builder Errors**: Usually caused by Java version mismatch - ensure correct Java version
- **Symbol Not Found**: Often indicates missing dependencies or incorrect imports in tests
- **Constructor Signature Mismatches**: Update test mocks to match actual constructor parameters
- **onConstructor_ Errors**: Lombok feature compatibility issue - resolved by using correct Java version

### Commands to Always Run After Changes
```bash
# Use project-appropriate Java version
JAVA_HOME=/path/to/correct/java ./gradlew clean
JAVA_HOME=/path/to/correct/java ./gradlew compileJava
JAVA_HOME=/path/to/correct/java ./gradlew test
```

### CRITICAL: Environment Variables for Deployment
**ALWAYS check for new environment variables before finalizing development:**
1. **Review application.properties** - Check for any new `${VARIABLE_NAME}` references
2. **Add to common.yaml** - All new variables (except AWS_* and DP_*) must be added to `codepipeline/configs/common.yaml`
3. **Location in common.yaml** - Add new variables to the "keys" section under the hedwig service prefix
4. **Format**: `"VARIABLE_NAME": {}`
5. **Never skip this step** - Missing environment variables will cause deployment failures
6. **IMPORTANT**: Do NOT add test-specific environment variables to common.yaml - only deployment variables

- ALWAYS verify that the code builds successfully after making changes
- For Java projects, run `./gradlew build` to verify compilation and build
- For critical fixes, run `./gradlew test` to verify all tests pass
- Always resolve compilation errors before submitting code
- When making changes that might affect dependencies, ensure the build completes successfully
- For type-related changes, verify that all type checks pass before proceeding


## ⚠️ CRITICAL GIT POLICY - ABSOLUTE PROHIBITION ⚠️
**NEVER RUN ANY GIT COMMANDS WHATSOEVER**
- NO git status, git log, git diff, git ls-files, git branch, git show, or ANY git command
- NO git commands that read repository state
- NO git commands that modify repository state
- NO git commands for information gathering
- NO exceptions - ZERO git interaction allowed
- I handle ALL git operations manually - you NEVER touch git
- Your role is ONLY making code changes - NOTHING related to git
- If you need git information, ask me to provide it manually
- If tasks mention git, immediately tell me to handle git operations myself
- REMEMBER: Even "harmless" git commands like git status are FORBIDDEN

### When Git Information Is Needed
**ALWAYS provide the exact commands for the user to run:**
- Don't just say "I can't run git commands"
- Be helpful by giving the specific git commands they should run
- Ask them to share the output so you can help interpret results
- Example: "I can't run git commands, but you can check this by running: `git status` and share the output with me"

## Enhanced Planning and Analysis Methodology

### Pre-Implementation Phase
- **Objective Decomposition**: Think through how to achieve the objective in small, logical chunks before any coding
- **Codebase Discovery**: Use search tools (Grep, Glob, Task) to understand existing patterns, conventions, and architecture
- **Context Gathering**: Read relevant files to understand current implementation approaches, dependencies, and code style
- **Learning Documentation**: Capture insights from codebase exploration for future reference

### Detailed Planning Strategy
- **Create todo.local.md**: Always write a detailed todo file BEFORE starting any coding work
- **Task Breakdown**: Split all work into small, logical chunks with clear objectives
- **Dependency Mapping**: Identify task order and dependencies between components
- **Learning Capture**: Store discoveries about codebase patterns, existing utilities, and architectural decisions in todo.local.md
- **Session Continuity**: Document intermediate learnings and progress to enable seamless continuation in future sessions

### Implementation Workflow
- **todo.local.md First**: Never jump to coding - always create comprehensive todo list first
- **Gitignore Management**: Ensure todo.local.md is added to .gitignore to prevent accidental commits
- **Incremental Progress**: Update both TodoWrite tool and todo.local.md after each completed step
- **Knowledge Retention**: Store any intermediate learnings, gotchas, or insights in todo.local.md
- **Step-by-Step Execution**: Complete one small logical chunk at a time with validation

### Documentation and Continuity
- **Progress Tracking**: Maintain detailed status in both todo tools and todo.local.md
- **Context Preservation**: Record enough detail for future sessions to understand decisions and progress
- **Learning Repository**: Use todo.local.md as a knowledge base for the current task/project

## Critical todo.local.md Management for Session Recovery

### Real-time Status Updates
- **After Every Step**: Immediately update todo.local.md when completing any task or sub-task
- **Current Status Tracking**: Always maintain a "Progress" section showing what's completed, in-progress, and pending
- **Live Documentation**: Record findings, issues encountered, and solutions as they happen
- **State Preservation**: Document the exact state of the work so sessions can resume seamlessly

### Session Recovery Strategy
- **Why This Matters**: Things crash, sessions disconnect, or work gets interrupted - without updated todo.local.md, recovery is difficult
- **Resume Capability**: Any new session should be able to read todo.local.md and immediately understand:
    - What has been completed
    - What is currently in progress
    - What issues were encountered and how they were solved
    - What discoveries were made about the codebase
    - What the next logical steps are

### Maintenance and Cleanup
- **Compact Old Information**: After completing major milestones, consolidate completed tasks into summary form
- **Archive Details**: Move detailed debugging info to an "Issues Encountered" section once resolved
- **Keep Essential**: Preserve key discoveries and patterns learned, remove temporary debugging notes
- **Focus on Future**: Ensure todo.local.md remains useful for future sessions, not cluttered with obsolete details

### Integration with TodoWrite Tool
- **Dual Tracking**: Use both TodoWrite tool (for current session) and todo.local.md (for persistence)
- **Sync Status**: When marking tasks complete in TodoWrite, immediately update todo.local.md
- **Cross-Reference**: todo.local.md should provide more context than the brief TodoWrite entries
- **Handoff Ready**: todo.local.md should enable smooth handoff to future sessions or team members

## Generic Code Quality Expectations
- Do not create very large methods and large files
- Output **production-ready**, idiomatic code
- Prioritize **clarity**, **correctness**, and **maintainability** over cleverness
- Avoid "toy" or demo-quality shortcuts unless explicitly requested
- Have smaller functions with single responsibility and testable function and code
- Always prefer composition over inheritance
- Follow SOLID principles and clean code practices
- Write self-documenting code with meaningful variable and function names

## ⚠️ CRITICAL CODE CLEANLINESS POLICY ⚠️
- **NO COMMENTS EVER** - Write self-documenting code with clear method/variable names instead
- **NO DEBUG LOGS** - Only add error logs for actionable issues with relevant context
- **NO UNNECESSARY LOGS** - Avoid verbose logging that clutters the codebase
- **Clean, Minimal Code** - Every line should serve a purpose
- **Method Names Tell the Story** - If you need a comment, improve the method name instead
- **Variable Names Are Documentation** - Use descriptive names that make code self-explanatory

## Language-Specific Guidelines

### Java
- **Check Project Java Version**: Always check build.gradle for sourceCompatibility/targetCompatibility before coding
- Use the project-specified Java version and appropriate features for that version
- Leverage sealed classes and interfaces where appropriate (Java 17+)
- Use Optional properly to avoid null pointer exceptions
- Prefer immutable objects and final fields when possible
- Follow standard naming conventions (camelCase for methods/variables, PascalCase for classes)
- Use streams and functional programming features judiciously
- Implement proper exception handling with specific exception types

### Go
- Instead of creating very large files, create sub-folders for logical areas if needed
- Split logical parts using files or sub-folders to keep code clean and easy to debug
- Follow Go conventions: use gofmt, golint, and go vet
- Keep functions small and focused on a single responsibility
- Use proper error handling with explicit error returns
- Prefer interfaces for abstraction and testability
- Use channels and goroutines appropriately for concurrency
- Follow effective Go naming conventions (short, descriptive names)

### Python
- Use Python 3.10+ features and syntax
- Create .venv for Python projects when needed
- Use typed classes and objects and try to avoid dicts - as typed objects are easy to manage and can detect errors easily + IDE friendly
- Use type hints extensively with typing module
- Follow PEP 8 style guidelines
- Use dataclasses or Pydantic models for structured data
- Prefer f-strings for string formatting
- Use context managers (with statements) for resource management
- Implement proper logging instead of print statements
