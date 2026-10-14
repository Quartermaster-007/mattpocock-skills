# Multi-repo specs

When the tickets span more than one repo, each repo gets its own **integration branch**, all with the same name, each cut from that repo's default branch.

## Working directory

The session's working directory is the **root** every `isolation: worktree` subagent forks from. Keep it in the repo you launched from for the whole run, and drive every other repo with `git -C <path>` and `(cd <path> && …)` subshells. A bare `cd` re-roots the session: the next isolated subagent then lands in the wrong repo.

## Worktrees outside the launch repo

The worktree isolation covers only the launch repo. For the others, create each implementer's worktree yourself, under `<repo>/.claude/worktrees/<name>` from that repo's integration branch, after adding `.claude/worktrees/` to `<repo>/.git/info/exclude`. Install dependencies and run the suite once there, then hand the implementer the absolute path instead of `isolation`.

## Cross-repo seams

One repo **owns** each contract between the repos. Implementers in the other repos read it from the owner's integration branch (`git -C <owner> show origin/<integration-branch>:<path>`) and never restate it. Order the frontier so the owner's ticket merges first.

## Paired branches

A test in one repo that reads the other repo's files must compare against the paired integration branch, not the other repo's working copy. Open one PR per repo and tell the user to merge them together.
