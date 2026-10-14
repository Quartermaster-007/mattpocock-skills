---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Before building, check the ticket's **Suggested pickup** (skill · model · effort) against the model and effort this session runs on:

- **Match**: carry on.
- **Mismatch**, or a model this harness doesn't offer: say so in one line and ask whether to continue. The user can restart with `/model`.
- **No pickup**: state the model and effort you run on, then carry on.

Compare effort only when the session exposes it.

Use /tdd where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work.

Commit your work to the current branch.
