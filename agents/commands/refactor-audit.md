---
description: Scan code for refactors and locality of behaviour, report, then apply the findings you approve. Optional scope argument.
allowed-tools: Read, Grep, Glob, Bash(git:*), Agent
---

# Refactor Audit

Scan code for structural smells and locality of behaviour (LoB) problems. Report the findings. Wait for approval. Apply only the approved findings.

Scope: $ARGUMENTS

## Phases

Run the phases in order. Do not skip a phase.

1. Resolve the scope.
2. Scan. Do not change any file.
3. Report.
4. Wait for approval.
5. Apply.

---

## Phase 1: Resolve the scope

Convert the scope text to a list of files.

- If the scope is empty, use every tracked file: `git ls-files`.
- If the scope names a path, use the files under that path.
- If the scope means "branch", use the files that the current branch changed against the default branch: `git diff --name-only <default>...HEAD`.
- If the scope means "uncommitted", use `git diff --name-only HEAD` and `git ls-files --others --exclude-standard`.
- If the scope means "staged", use `git diff --name-only --cached`.
- If the scope names commits, use `git diff --name-only` for that range.

If the scope text fits none of these rules, ask the user what the scope means. Do not guess.

Skip generated code, build output, vendored dependencies, lockfiles, and deleted files.

Print the resolved scope in one line: the rule that you used and the number of files.

---

## Phase 2: Scan

Use `Read`, `Grep`, and `Glob` to inspect the files. Read the callers and importers of each candidate. A unit can look dead or duplicated inside a diff and be used outside the scope.

Note the exact `path:line` and the unit name for each finding.

### Structural smells

- **Long function or god class**: a unit does four or more distinct things.
- **Duplication**: near-identical logic in three or more places. Do not flag two copies.
- **Primitive obsession**: a raw string or number carries meaning that a named type states better.
- **Feature envy**: a method mostly uses the data of another class.
- **Unclear name**: single letters, private abbreviations, or names that state how instead of what.
- **Deep nesting**: three or more levels, flag arguments that switch behavior, or if/else chains that act as a decision table.
- **Dead code**: exports that nothing imports, private functions that nothing calls, files with no importers.
- **Scattered logic**: one concept spread across files with no clear owner.
- **Middle-man wrapper**: a function or class that only delegates.
- **Awkward data shape**: parallel arrays, mutable globals, or more than four positional parameters.

### Locality of behaviour smells

The behavior of a unit must be clear from that unit alone.

- **Detached behavior**: a distant selector, listener, or config file attaches behavior to a unit. The fix is to declare the behavior on the unit.
- **Hidden dependency**: the unit works only because a distant file sets something up. The fix is to make the call site explicit.
- **Deduplication that moves behavior away**: shared code lives in a separate file and the unit no longer shows what it does. LoB wins over DRY here. The fix is to keep the call local and move only the implementation detail.

Do not confuse LoB with inlining complex implementation details. The call or binding must stay local. The implementation can live in a separate function or module.

### Do not flag

- Correctness bugs. Route them to a code review.
- Security holes. Route them to a security review.
- Performance problems.
- Style preferences with no structural payoff.
- Deliberate verbosity in tests. Flag test helpers only if they are duplicated across test files.

---

## Phase 3: Report

Group the findings by category. Print only the categories that have findings. Number each category (1, 2, 3, …). Number each finding inside a category as a minor of that number. For example, `2.3` is the third finding in the second category.

### Categories

| Tag | What it covers |
|-----|----------------|
| `extract` | Pull a function, class, or module out of a too-large unit |
| `inline` | Remove an unnecessary indirection |
| `move` | Move code to a better home (feature envy, scattered logic) |
| `rename` | Replace an unclear name |
| `simplify` | Flatten conditionals, use guard clauses, replace loops with pipelines |
| `dedupe` | Merge three or more duplicate blocks into one location |
| `reorganize-data` | Primitive obsession, parallel arrays, type codes |
| `remove-dead` | Delete unused code |
| `api-surface` | Flag arguments, parameter objects, query and modifier split |
| `localize` | Fix a LoB smell: put the behavior on the unit that it affects |

### Format

Use one table for each category. Keep each cell to one logical line. State the smell as a fact. State the fix as a direction, not a full plan.

```
## 1. extract

| # | Where | Smell | Fix |
|---|-------|-------|-----|
| 1.1 | src/orders.ts:45-180 | processOrder does validation, pricing, persistence, notification | Extract validateOrder, calculatePrice, persistOrder, notifyCustomer |

## 2. localize

| # | Where | Smell | Fix |
|---|-------|-------|-----|
| 2.1 | src/menu.ts:12 | Click handler for #menu-btn lives in src/events.ts | Declare the handler on the button |
```

End the report with this line:

```
total: <M> findings across <K> categories.
```

If you find nothing, print `Lean and local. Ship.` and stop. Do not invent findings.

Then ask the user which findings to apply. Accepted answers:

- `all`
- a list of IDs, for example `1.1 2.3`
- a category number, for example `2`
- `none`

---

## Phase 4: Wait for approval

Stop after the question. Do not change any file before the user answers.

If the user picks a subset, apply only that subset. If the user asks to change a finding, change the finding and ask again. If the user answers `none`, stop.

---

## Phase 5: Apply

Delegate the approved findings with the `Agent` tool. Use one subagent for each approved category.

The subagent has no audit context. Write each brief so that it stands alone:

- the category tag and what it means
- the list of approved findings, each with `path:line`, the smell, and the fix
- the rule that the subagent changes only the listed findings
- the rule that the subagent follows the existing style of the repo
- the rule that the subagent does not commit
- the request for a summary of the files that it changed

Rules for the run:

- If two categories touch the same file, run those subagents one after the other. Run the other subagents at the same time.
- If a subagent finds that a finding is wrong or unsafe, it must skip the finding and say why.
- Do not let a subagent widen the scope. New problems go in the summary as new findings.

After all subagents finish, run `git diff --stat`. Print this summary:

- the findings that were applied
- the findings that were skipped, with the reason
- the new findings that the subagents reported

Do not commit. The user decides when to commit.

---

## Boundaries

- This command is about structure and locality, not behavior. A refactor must keep the behavior the same.
- The audit is a snapshot. If the repo changes, run the command again.
- Do not apply a finding that the user did not approve.
