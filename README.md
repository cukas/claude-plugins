# cukas Claude Code Plugins

Personal plugin marketplace for Claude Code.

## Plugins

| Plugin | Description | Repo |
|--------|-------------|------|
| **remembrall** | Never lose context again — auto-saves your work when Claude Code's context window runs low | [cukas/remembrall](https://github.com/cukas/remembrall) |
| **workflow-skills** | Battle-tested dev workflow: `/plan-guarded`, `/bugfix`, `/review-checklist` with automatic chaining | [cukas/claude-workflow-skills](https://github.com/cukas/claude-workflow-skills) |

## Installation

Add this marketplace to Claude Code, then install plugins from it:

```bash
claude plugins marketplace add cukas --from github:cukas/claude-plugins
claude plugins install remembrall@cukas
claude plugins install workflow-skills@cukas
```
