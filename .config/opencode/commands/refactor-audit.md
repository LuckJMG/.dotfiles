---
description: Audit the whole repo for refactoring
agent: plan
model: minimax/MiniMax-M3
---

# Refactor Audit

Audit a whole repository for refactoring opportunities, present them as a
grouped report, and on selection emit self-contained instruction blocks
another agent can execute. You never apply refactors yourself in this
session — the output is a menu plus, on request, executable instructions.

## Why this command exists

Refactoring is easier to commit to when the candidate list is visible up
front and each item is small enough to reason about. A developer who can see
"17 findings across 6 categories" can pick the 3 that matter and ignore the
rest; a developer told "this code is messy" stalls. The grouped report makes
the work legible, and the instruction-block format lets the chosen refactors
be handed off to a fresh agent session that has no audit context — so the
audit and the application happen in separate, focused contexts.

## The three phases

Run them in order. Do not skip ahead.

1. **Audit** — scan the whole repo, collect smells. No fixes.
2. **Report** — group findings by category, number them, present to user.
3. **Select** — user picks; for each pick, emit one instruction block.

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
cells concise — smell is a factual summary, fix is the direction (the full
plan comes in Phase 3 if selected). Long cells wrap in the TUI; that's fine,
but keep each cell to one logical line so the row stays scannable.

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
direction, not a full plan. Both stay short — the plan comes in Phase 3.

### Report close

End the report with one summary line:

```
total: <M> findings across <K> categories.
```

If you found nothing, say `Lean already. Ship.` and stop — don't manufacture
findings to justify the audit. A clean result is a valid outcome.

---

## Phase 3: Select

After the report, ask the user which refactors they want to proceed with:

> Which refactors? Reply numbers (`1.1, 2.3, 3.1`), category (`all 1` or
> `all extract`), or `none`.

Wait for their reply. Do not assume a selection.

### Instruction block format

For each selected finding, emit one self-contained block. "Self-contained"
is the critical property: another agent receiving only this block — with no
audit report, no conversation history, no other blocks — must have
everything it needs to execute the refactor. If a block references "the
validation function from 2.1" or "as discussed above," it has failed.

Use exactly this structure for each block:

```
## Refactor M.N: <short title>

Target: <file:line range or symbol name>
Action: <verb phrase — "Extract X into Y", "Move X from A to B", "Rename X to Y">
Why: <the smell this fixes, one sentence>

Before:
  <minimal code snippet showing the current state — just enough to locate and recognize it>

After:
  <minimal code snippet showing the target state — the shape, not necessarily compilable pseudocode>

Verify: <how to confirm it worked — a command, a test name, or a manual check>
```

### Why each field

- **Target** — the executing agent needs to know what file and what region.
  A line range is more robust than a symbol name if names are about to change.
- **Action** — the verb phrase anchors the work. "Extract", "Move", "Rename",
  "Inline", "Delete", "Replace" — each implies a known sequence of steps.
- **Why** — without the why, the executing agent might "improve" the refactor
  in a way that undoes the structural fix. The why constrains the change.
- **Before / After** — the executing agent works from the *shape* of the
  target, not from a diff against the current file (which may have shifted
  by the time it runs). Keep snippets minimal — show the structure, not the
  full implementation. Omit lines that don't illustrate the refactor.
- **Verify** — a refactor with no check is unfinished. The check can be a
  test command (`npm test -- orders`), a specific test name, or a manual
  confirmation ("grep for processOrder — should return 0 hits"). Pick the
  smallest check that fails if the refactor didn't happen or broke something.

### If the user selects a category (`all extract`)

Emit one block per finding in that category, in numbered order.

### If the user replies `none`

Stop. The report stands on its own.

---

## Boundaries

- **Audit only in this session.** You never apply refactors here. The
  instruction blocks are for another agent, another session. This separation
  keeps the audit focused on *what* to change, and the application focused on
  *how* to change it — two different modes of attention.
- **No correctness, security, or performance findings.** Route those to a
  normal review. This skill is about structure, not behavior.
- **No style nits without structural payoff.** A name that's unclear has
  payoff (future readers will misread it). A missing trailing comma does not.
- **Standalone.** Don't cross-reference other audit or review skills — the
  output should be usable without knowing they exist.
- The audit is a snapshot. If the user edits the repo and re-runs, findings
  may shift — that's expected.

