---
{
  "format_version": 2,
  "created": "2026-03-09T09:15:20Z",
  "session_id": "bcc1fa24-c4ea-43f0-8ac4-d86dbf76ae71",
  "previous_session": "",
  "project": "/Users/nicolascukas/GitHub/claude-plugins",
  "status": "in_progress",
  "branch": "main",
  "commit": "716dc8e",
  "patch": "",
  "files": [
    "~/.claude/CLAUDE.md",
    "~/Web/audiofacets/.claude/settings.json",
    "~/Web/audiofacets/.claude/skills/plan-guarded/SKILL.md",
    "~/Web/audiofacets/.claude/skills/bugfix/SKILL.md",
    "~/Web/remembrall/skills/handoff/SKILL.md",
    "~/Web/remembrall/skills/replay/SKILL.md",
    "~/GitHub/claude-plugins/README.md",
    "~/GitHub/claude-plugins/.claude-plugin/marketplace.json",
    "~/GitHub/claude-workflow-skills/README.md",
    "~/GitHub/claude-workflow-skills/.claude-plugin/plugin.json",
    "~/GitHub/claude-workflow-skills/skills/plan-guarded/SKILL.md",
    "~/GitHub/claude-workflow-skills/skills/bugfix/SKILL.md",
    "~/GitHub/claude-workflow-skills/skills/review-checklist/SKILL.md",
    "~/.claude/skills/plan-guarded/SKILL.md",
    "~/.claude/skills/bugfix/SKILL.md",
    "~/.claude/skills/review-checklist/SKILL.md",
    "~/.claude-privat/plugins/installed_plugins.json",
    "~/.claude-privat/plugins/known_marketplaces.json"
  ],
  "tasks": [
    "Verify marketplace install works end-to-end on fresh machine",
    "Bump remembrall version to include handoff/replay active-skill tracking",
    "Test workflow-skills plugin install from marketplace",
    "Update remembrall README install instructions to use cukas/claude-plugins marketplace"
  ],
  "team": true
}
---

# Session Handoff

**Task:** Adopt insights report suggestions — add CLAUDE.md rules, hooks, skills, and set up a personal plugin marketplace (cukas/claude-plugins) with remembrall, patrol, and workflow-skills plugins.
**Active Skill:** none (ad-hoc implementation session)

## Completed
- Added global CLAUDE.md rules (~/.claude/CLAUDE.md): root-cause investigation mandate, no premature done, follow user approach, implement don't just plan, mandatory review-checklist after implementation
- Added ARA/AU platform limitation to audiofacets project CLAUDE.md
- Wired plugin-companion auto-rebuild hook into audiofacets .claude/settings.json
- Chained review-checklist into plan-guarded and bugfix skills (audiofacets project-level)
- Created workflow-skills plugin repo (cukas/claude-workflow-skills) with generalized plan-guarded, bugfix, review-checklist skills — pushed to GitHub
- Created global ~/.claude/skills/ copies of all three skills
- Added active-skill tracking to remembrall handoff/replay skills (~/Web/remembrall/)
- Created cukas/claude-plugins marketplace repo with submodules + marketplace.json
- Marketplace registered and working: `claude plugin marketplace add cukas/claude-plugins`
- All three plugins install from marketplace: remembrall@cukas, patrol@cukas, workflow-skills@cukas
- Cleaned stale plugin caches (old remembrall versions, old remembrall@remembrall entry, tmp patrol debris)

## Next Step — Do This First
Verify the marketplace install works cleanly on the user's other laptop. Run `claude plugin marketplace add cukas/claude-plugins` then install all three plugins and test `/remembrall-status`, `/patrol-status`, and `/plan-guarded` each work.

## Remaining (after next step)
1. Bump remembrall to include the handoff/replay active-skill tracking changes (~/Web/remembrall/skills/handoff/SKILL.md and replay/SKILL.md were modified)
2. Update remembrall README.md install instructions to reference cukas/claude-plugins marketplace instead of standalone
3. Update submodule in cukas/claude-plugins after remembrall release
4. Consider updating patrol README similarly

## Do NOT Do
- Do not merge all plugins into one monorepo — user explicitly wants separate repos
- Do not create root-level skills/hooks/commands in claude-plugins repo — it's a marketplace catalog only
- Do not touch ~/.remembrall/ config/handoffs — that's user data
- Do not re-debate the marketplace vs single-plugin approach — decided: marketplace with submodules pointing to standalone repos
- Do not modify the audiofacets CLAUDE.md beyond what was already added — it was already comprehensive

## Key Decisions
- Global CLAUDE.md rules apply everywhere; project CLAUDE.md has project-specific rules (already existed for audiofacets)
- Skills chain: plan-guarded and bugfix both mandate invoking review-checklist before done
- Hooks can't invoke skills — CLAUDE.md rules + skill-internal instructions are the enforcement mechanism
- Marketplace uses submodules so each plugin stays in its own repo but marketplace has full code
- marketplace.json uses `"source": "./plugins/name"` (local paths) not remote URLs — matches official marketplace pattern
- Plugin install command is `claude plugin` (singular) not `claude plugins`

## Files Modified
- `~/.claude/CLAUDE.md` — added Debugging, Code Review, General Rules sections
- `~/Web/audiofacets/.claude/CLAUDE.md` — added Known Platform Limitations (ARA/AU)
- `~/Web/audiofacets/.claude/settings.json` — added plugin-companion rebuild PostToolUse hook
- `~/Web/audiofacets/.claude/skills/plan-guarded/SKILL.md` — chained review-checklist
- `~/Web/audiofacets/.claude/skills/bugfix/SKILL.md` — chained review-checklist
- `~/Web/remembrall/skills/handoff/SKILL.md` — added active skill tracking
- `~/Web/remembrall/skills/replay/SKILL.md` — added active skill tracking + resume step
- `~/GitHub/claude-plugins/` — new marketplace repo (README, marketplace.json, submodules)
- `~/GitHub/claude-workflow-skills/` — new plugin repo (3 skills + plugin.json)
- `~/.claude/skills/` — global copies of plan-guarded, bugfix, review-checklist
- `~/.claude-privat/plugins/installed_plugins.json` — removed stale remembrall@remembrall entry
- `~/.claude-privat/plugins/known_marketplaces.json` — repointed cukas to claude-plugins

## Context
- User has superpowers plugin installed which provides systematic-debugging, verification-before-completion, brainstorming etc. — these complement but don't replace the new rules/skills
- Remembrall v2.5.0 is currently installed but the handoff/replay changes haven't been released yet
- The user runs Claude Code ~20 sessions/day across multiple laptops — marketplace enables consistent setup
- User gets frustrated when Claude applies band-aid fixes or declares done prematurely — the global CLAUDE.md rules directly target this

## Open Questions
- Should remembrall README install instructions change from `claude plugin marketplace add cukas/remembrall` to `cukas/claude-plugins`?
- Should patrol README be updated similarly?
