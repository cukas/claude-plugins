# cukas — Claude Code Plugins

A curated collection of plugins built from real-world development — 451 sessions, 651 hours, and a lot of lessons learned.

## Install

```bash
claude plugin marketplace add cukas/claude-plugins
```

Then browse and install from `/plugin` > Discover, or:

```bash
claude plugin install remembrall@cukas
claude plugin install patrol@cukas
claude plugin install workflow-skills@cukas
```

---

## Plugins

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

Stops Claude from jumping to fixes before understanding the problem. Auto-detects bug-fix sessions, tracks which files Claude reads vs edits, and escalates if it starts patching without investigating.

```
Normal coding                     → silent (zero tokens)
Bug-fix detected                  → investigation gate active
  Edit without Read               → 🔵 nudge
  3+ patches without reading      → 🟡 warning
  4+ patches, no investigation    → 🚨 STOP
  Files changed, no build/test    → 🔧 reminder
```

```bash
claude plugin install patrol@cukas
```

[View repo](https://github.com/cukas/patrol)

---

### Workflow Skills

> *Plan it. Guard it. Review it. Every time.*

Three skills that chain together for disciplined development:

| Skill | What it does |
|-------|-------------|
| `/plan-guarded` | Plan first, get approval, implement one file at a time with type-check and test after each change |
| `/bugfix` | Write a failing test, fix until green, no hand-holding — surfaces only when done |
| `/review-checklist` | Trace affected paths, check for null/async/stale-data bugs, verify builds and tests |

```
/plan-guarded  →  implement  →  /review-checklist (automatic)
/bugfix        →  test loop  →  /review-checklist (automatic)
```

```bash
claude plugin install workflow-skills@cukas
```

[View repo](https://github.com/cukas/claude-workflow-skills)

---

## Quick Start

```bash
# Add the marketplace
claude plugin marketplace add cukas/claude-plugins

# Install what you need
claude plugin install remembrall@cukas
claude plugin install patrol@cukas
claude plugin install workflow-skills@cukas
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
- **Verify before declaring done** (Workflow Skills)

Built by [@cukas](https://github.com/cukas). MIT licensed.
