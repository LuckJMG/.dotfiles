---
description: Scan code for refactors and locality of behaviour, report, then apply the findings you approve. Optional scope argument.
allowed-tools: Read, Grep, Glob, Bash(git:*), Agent, Skill
---

Run the `audit` skill with the Skill tool. Use the audit context below.

Scope: $ARGUMENTS

## Hunt

Look for structural smells and locality of behaviour (LoB) problems.

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

### LoB smells

The behavior of a unit must be clear from that unit alone.

- **Detached behavior**: a distant selector, listener, or config file attaches behavior to a unit. The fix is to declare the behavior on the unit.
- **Hidden dependency**: the unit works only because a distant file sets something up. The fix is to make the call site explicit.
- **Deduplication that moves behavior away**: shared code lives in a separate file and the unit no longer shows what it does. LoB wins over DRY here. The fix is to keep the call local and move only the implementation detail.

Do not confuse LoB with inlining complex implementation details. The call or binding must stay local. The implementation can live in a separate function or module.

## Skip

- Correctness bugs. Route them to a code review.
- Security holes. Route them to a security review.
- Performance problems.
- Style preferences with no structural payoff.
- Deliberate verbosity in tests. Flag test helpers only if they are duplicated across test files.

## Groups

Number the groups in the order of this table.

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

## Columns

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

## Close

```
total: <M> findings across <K> groups.
```

No findings: `Lean and local. Ship.`

## Brief

- The change must keep the behavior the same.

## Summary

None.
