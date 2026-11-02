---
name: implement-spec
description: "Implement the result of /to-spec and /to-tickets in code."
disable-model-invocation: true
---

You have been provided a spec. This spec should have tickets associated with it, describing how to implement the spec.

The issue tracker should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`.

The goal is the entire spec implemented on a single **integration branch**, with every ticket resolved the way the issue tracker closes work.

The tickets are not a list of steps. They are a **task graph** with blocking relationships between them. This means there is always a **frontier** of tickets which are ready to be grabbed.

Start every subagent with a fresh context window.

Communication to and from subagents should be sparse. Communicate primarily through **context pointers**: to the spec, tickets, research notes, and previous commits. Don't duplicate information already available via pointers.

**Implementer subagents** should be run in the background where possible for maximum concurrency.

Tickets spanning more than one repo: read [`MULTI-REPO.md`](MULTI-REPO.md) before step 4.

## Steps

1. Read the spec and tickets to understand the task graph.

2. Build the **pickup plan**: the model and effort each subagent runs on. One row per ticket, plus one each for the exploration, merger and review-fix subagents.
   - A ticket with a **Suggested pickup** keeps its model and effort. Its skill does not apply here: implementers drive `tdd`, and step 8 runs one `code-review`.
   - A ticket without one gets a proposal, sized the way `/to-tickets` sizes a pickup: a mechanical, well-specified ticket gets a smaller model at low effort; one heavy on judgement or cross-cutting design gets the most capable model at high effort. Mergers are mechanical.
   - A model or effort the user gave in the arguments overrides the plan.
   - A pickup naming a model or effort the subagent tool doesn't accept, or a model this harness doesn't offer, goes to the user; the session's own model never silently replaces it.

   Show the plan, marking proposals, and wait for the user's go-ahead unless the arguments already settle every row. Every subagent then runs on its row's `model` and `effort`.

3. (optional) Use an **exploration subagent** to conduct any exploration required by the tickets - relevant codebase files or external documentation. Ensure the exploration subagent can save files - it should save its markdown notes in a directory outside the repo, accessible by all future subagents. This lets **implementer subagents** focus on implementation rather than exploration.

4. Create the integration branch. If the issue tracker closes work through PRs, or the user asks for one, open a draft PR after the first merge in step 6 (a branch with no commits ahead of main can't open one), marked as closing the spec and tickets.

5. Use a fresh **implementer subagent** for each ticket, each in its own worktree on its own branch. Each implementer subagent:
   - confirms its worktree is based on the integration branch before starting, and resets onto it if not;
   - calls the Skill tool with `tdd` to build the ticket;
   - merges the integration branch tip into its own branch before reporting done

6. Once an **implementer subagent** completes, merge its work to the integration branch with a **merger subagent**. The merger runs the repo's full test suite on the merge result and pushes only when it is green; on red it resets to the previous tip and reports. Its merge commit message is just the summary line and trailers, with any `# Conflicts:` lines removed.

7. If this changes the **frontier** of available tickets, kick off more **implementer subagents** to work on the new tickets. This allows for maximum concurrency.

8. Once all tickets are complete, call the Skill tool with `code-review` on the integration branch. Fix all issues raised by the code review in a single fresh **implementer subagent**.

9. If a draft PR exists, mark it ready for review. Otherwise, resolve each ticket the way the issue tracker closes work, and report the integration branch.

10. Clean up all **implementer subagent** worktrees.
