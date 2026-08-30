---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Use /tdd where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work.

When working from tickets, update each ticket as you complete it: check off the acceptance criteria you verified, and update the ticket's `Status:` line to reflect the new state.

Never commit or push your work. This is a human's responsibility, never your task.
