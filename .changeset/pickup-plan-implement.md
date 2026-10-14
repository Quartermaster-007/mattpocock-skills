---
"mattpocock-skills": minor
---

`implement` and `implement-spec` now act on a ticket's suggested pickup, and `implement-spec` handles specs that span several repos.

- `implement` checks the ticket's **Suggested pickup** against the session's model and effort before building: it carries on when they match, asks whether to continue on a mismatch or a model the harness doesn't offer, and names its own model and effort when the ticket has no pickup.
- `implement-spec` builds a **pickup plan** before creating the integration branch: one model and effort per ticket from its pickup, a proposal where a ticket has none, and rows for the exploration, merger and review-fix subagents. Arguments override the plan; every subagent then runs on its row instead of inheriting the orchestrator's model.
- `implement-spec`'s merger pushes only on a green full suite and strips `# Conflicts:` lines from its merge commit.
- `implement-spec` gains `MULTI-REPO.md`: one integration branch per repo, the orchestrator stays rooted in the launch repo, it creates the other repos' worktrees itself, and one repo owns each cross-repo contract.
