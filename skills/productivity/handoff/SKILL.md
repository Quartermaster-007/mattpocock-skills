---
name: handoff
description: Compact the current conversation into a handoff document for another agent to pick up.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Write a handoff document summarising the current conversation so a fresh agent can continue the work. Start it with the heading `## Handoff`.

## Where it goes

- **The relevant ticket**, when the work in flight belongs to a ticket on the project issue tracker (the user names one, or the conversation is working one). Post the handoff as a comment on that ticket, so the next session picks it up from there. On a local-markdown tracker, write it as the `## Handoff` section at the end of the ticket file.
- **The user's Desktop** otherwise: `~/Desktop/handoff-<slug>-<YYYY-MM-DD-HHMM>.md`.

Never the OS temporary directory, never the current workspace. If it's unclear whether a ticket is the right home, ask. When done, give the user the file path or the comment URL.

## One handoff per ticket

A ticket carries only its most recent handoff. After posting the new one, look through the ticket's comments for earlier handoffs (a `## Handoff` heading, or a comment that is plainly a handoff) and delete them: the new one supersedes them. If the tracker won't let you delete a comment, edit it down to one line pointing at the new handoff. Leave every other comment alone. On a local-markdown tracker, replace the existing `## Handoff` section rather than adding a second.

## What goes in it

Include a "suggested skills" section in the document, naming which skills the next agent should call the Skill tool for.

Do not duplicate content already captured in other artifacts (specs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead. On a ticket, that includes the ticket's own body: don't restate it.

Redact any sensitive information, such as API keys, passwords, or personally identifiable information. This matters doubly on a ticket, which other people can read.

If the user passed arguments, treat them as a description of what the next session will focus on and tailor the doc accordingly.
