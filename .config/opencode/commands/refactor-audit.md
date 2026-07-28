---
description: Audit the whole repo for refactoring
agent: plan
---

# Refactor Audit

Audit a whole repository for refactoring opportunities and present them as a
grouped report.

## Why this command exists

Refactoring is easier to commit to when the candidate list is visible up
front and each item is small enough to reason about. A developer who can see
"17 findings across 6 categories" can pick the 3 that matter and ignore the
rest; a developer told "this code is messy" stalls. The grouped report makes
the work legible, and the instruction-block format lets the chosen refactors
be handed off to a fresh agent session that has no audit context — so the
audit and the application happen in separate, focused contexts.

## The phases

Run them in order. Do not skip ahead.

1. **Audit** — scan the whole repo, collect smells. No fixes.
2. **Report** — group findings by category, number them, present to user.

---

## Phase 1: Audit

Scan the entire repository tree. Use `glob` to find source files, `grep` to
locate patterns, and `read` to inspect candidates. Skip generated code,
build output, `node_modules`, `.git`, vendored deps, and lockfiles — they
aren't yours to refactor.

You are hunting for structural smells, not bugs. The smells that matter:

- **Long functions / god classes** — a unit doing 4+ distinct things, or a
  class with too many responsibilities.
- **Duplication** — near-identical logic in two or more places (same
  structure, different names or literals).
- **Primitive obsession** — a raw string or int carrying meaning that would
  be safer as a named type ("premium", "basic", status codes as magic numbers).
- **Feature envy** — a method that mostly touches another class's data
  instead of its own.
- **Unclear names** — single letters (`d`, `x2`), abbreviations only the
  author understood (`flg`, `usrInf`), or names that describe *how* not *what*.
- **Deep nesting / complex conditionals** — 3+ levels of nesting, flag
  arguments that switch behavior, nested if/else that reads as a decision table.
- **Dead code** — exported functions never imported, private functions never
  called, files with no importers.
- **Scattered logic** — one concept's logic spread across multiple files
  with no clear owner.
- **Middle-man wrappers** — a function or class that only delegates, adding
  no behavior.
- **Awkward data shapes** — parallel arrays that should be one array of
  records, mutable globals, parameter lists over 4 positional args.

When you find a smell, note the exact `path:line` and the unit it lives in.
You'll need both for the report.

### Scope guardrails

Do not flag:
- Correctness bugs (broken logic) — route to a normal review.
- Security holes — route to a security review.
- Performance issues — route to a perf pass.
- Style preferences with no structural payoff (indentation, quote style).
- Test code's own deliberate verbosity — only flag test helpers if they're
  duplicated across test files.

---

## Phase 2: Report

Present findings grouped under category headings. Use only the categories
that have findings — don't print empty headings. Number each category
section sequentially (1, 2, 3, …) and number each finding within its
section as a minor of that section — so `2.3` means the third finding in
the second category. The full ID is unique and unambiguous when the user
selects, and the major number tells them which category at a glance.

### Categories

| Tag | What it covers |
|-----|----------------|
| `extract` | Pull a function, class, or module out of a too-large unit |
| `inline` | Remove unnecessary indirection (delegating wrapper, one-call middleware) |
| `move` | Relocate a function, field, or statement to a better home (fixes feature envy, scattered logic) |
| `rename` | Replace unclear names — functions, variables, files, modules |
| `simplify` | Decompose conditionals, guard clauses, replace loops with pipelines, slide statements |
| `dedupe` | Merge duplicate logic across files into one shared location |
| `reorganize-data` | Primitive obsession, encapsulate fields, replace type code, parallel arrays → records |
| `remove-dead` | Delete unused exports, functions, or files |
| `api-surface` | Flag args, parameter objects, separate query from modifier |

### Finding line format

One markdown table per category section. Each row is one finding. Keep
cells concise — smell is a factual summary, fix is the direction. Long 
cells wrap in the TUI; that's fine, but keep each cell to one logical line 
so the row stays scannable.

```
## 1. extract

| # | Where | Smell | Fix |
|---|-------|-------|-----|
| 1.1 | src/orders.ts:45-180 | processOrder does validation, pricing, persistence, notification | Extract validateOrder, calculatePrice, persistOrder, notifyCustomer |
| 1.2 | src/users.ts:30-95 | UserManager handles CRUD, email, session expiry | Split into UserRepository, Mailer, SessionManager |

## 2. move

| # | Where | Smell | Fix |
|---|-------|-------|-----|
| 2.1 | src/orders.ts:133-141 | validateEmail/validatePhone general-purpose, not order-domain | Move to src/validation.ts |
```

The smell is what's wrong (factual, not judgmental). The fix is the
direction, not a full plan.

### Report close

End the report with one summary line:

```
total: <M> findings across <K> categories.
```

If you found nothing, say `Lean already. Ship.` and stop — don't manufacture
findings to justify the audit. A clean result is a valid outcome.

---

## Boundaries

- **No correctness, security, or performance findings.** Route those to a
  normal review. This skill is about structure, not behavior.
- **No style nits without structural payoff.** A name that's unclear has
  payoff (future readers will misread it). A missing trailing comma does not.
- **Standalone.** Don't cross-reference other audit or review skills — the
  output should be usable without knowing they exist.
- The audit is a snapshot. If the user edits the repo and re-runs, findings
  may shift — that's expected.

