---
"mattpocock-skills": minor
---

Tickets now carry a suggested pickup, `handoff` writes to the ticket or the Desktop, and `triage` ignores the tracker's workflow state.

- `to-spec`, `to-tickets`, `triage` (agent briefs) and `wayfinder` end every ticket they publish with a **Suggested pickup**: the skill, model, and effort level a fresh session should start it with. A ticket that builds code names `/implement`, never bare `/tdd`, so `/code-review` always runs.
- `handoff` posts the handoff on the relevant ticket, or saves it to the Desktop when there is none, instead of the OS temp directory. A ticket keeps only its newest handoff: earlier ones are deleted.
- `triage` no longer reads readiness into, flags, or changes the tracker's own workflow state (To Do, Doing, Done), which is separate from its triage labels.
