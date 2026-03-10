# cukas — Claude Code Plugins

Three battle-tested plugins built from real-world development — 451 sessions, 651 hours, and a lot of lessons learned. Zero external dependencies — just Claude Code's native hooks and skills.

## Install

```bash
claude plugin marketplace add cukas/claude-plugins
```

Then browse and install from `/plugin` > Discover, or:

```bash
claude plugin install remembrall@cukas
claude plugin install patrol@cukas
claude plugin install claudes-ai-buddies@cukas
```

---

## Plugins

### AI Buddies

> *Three AI engines. One decision. You pick who builds it.*

Pitch a task to Claude, Codex, and Gemini at once. Each gives a confidence %, approach, and risks. You see who's confident, who's hesitant — then pick who does the work.

```
/brainstorm "Fix the race condition in the WebSocket handler"

| | Claude | Codex | Gemini |
|---|---|---|---|
| Confidence | 85% | 70% | 60% |
| Approach | Trace reconnect... | Add mutex lock... | Exponential backoff... |
| Risks | Edge case in retry | Could deadlock | Masks root cause |

Recommendation: Claude — highest confidence, knows the codebase
```

| Skill | What it does |
|-------|-------------|
| `/brainstorm "task"` | Confidence bid — each AI rates the task, you pick who builds it |
| `/codex "prompt"` | Ask Codex anything — delegate, brainstorm, second opinion |
| `/gemini "prompt"` | Ask Gemini anything — different model, different perspective |
| `/codex-review` | Code review via Codex |
| `/gemini-review` | Code review via Gemini |

Works with any combination — Codex only, Gemini only, or both. Claude always participates.

```bash
claude plugin install claudes-ai-buddies@cukas
```

[View repo](https://github.com/cukas/claudes-ai-buddies)

---

### Remembrall

> *"It glows when you've forgotten something" — like your entire context window.*

Context runs out, work gets lost. Remembrall monitors your context window, auto-saves handoffs when it runs low, and lets you resume seamlessly with `/replay`. Zero config needed.

```
🔮 [███░░░░░░░] 28% ⚡  →  /handoff  →  /clear  →  /replay  →  back to work
```

```bash
claude plugin install remembrall@cukas
```

[View repo](https://github.com/cukas/remembrall)

---

### Patrol

> *"Investigate, you must. Band-aid, you must not."*

ESLint for Claude Code — adaptive rule engine with investigation gate, band-aid detection, and built-in workflow skills. Zero tokens during normal coding.

```
Normal coding                     → silent (zero tokens)
Bug-fix detected                  → investigation gate active
  Edit without Read               → 🔵 nudge
  3+ patches without reading      → 🟡 warning
  4+ patches, no investigation    → 🚨 STOP
  Files changed, no build/test    → 🔧 reminder
```

**Included skills** (previously standalone `workflow-skills` plugin):

| Skill | What it does |
|-------|-------------|
| `/build-guard` | Plan in plan mode, implement with subagent dispatch, type-check after every file, test every 3 files |
| `/trace-fix` | Trace root cause before touching code, TDD loop with escape hatch, fully autonomous |
| `/review-gate` | Structured pass/fail review — trace paths, scan for bugs, verify build/types/tests |
| `/diagnose` | Structured root-cause investigation before any code changes |

```bash
claude plugin install patrol@cukas
```

[View repo](https://github.com/cukas/patrol)

---

## Quick Start

```bash
# Add the marketplace
claude plugin marketplace add cukas/claude-plugins

# Install what you need
claude plugin install remembrall@cukas
claude plugin install patrol@cukas
claude plugin install claudes-ai-buddies@cukas
```

Or from inside Claude Code:
```
/plugin marketplace add cukas/claude-plugins
/plugin install remembrall@cukas
```

## Philosophy

These plugins exist because Claude is powerful but undisciplined. It jumps to fixes, skips investigation, forgets to rebuild, and declares done prematurely. These tools enforce the habits that make AI-assisted development actually work:

- **Investigate before fixing** (Patrol)
- **Never lose context** (Remembrall)
- **Get a second opinion** (AI Buddies)
- **Verify before declaring done** (Patrol — /review-gate)

Built by [@cukas](https://github.com/cukas). MIT licensed.
