---
description: Scan code for over-engineering, report what to cut, then apply the cuts you approve. Optional scope argument.
allowed-tools: Read, Grep, Glob, Bash(git:*), Agent, Skill
---

Run the `audit` skill with the Skill tool. Use the audit context below.

Scope: $ARGUMENTS

## Hunt

Look for code that the project does not need.

For each candidate, climb this ladder and stop at the first rung that holds:

1. The code does not need to exist.
2. The codebase already has a helper that does the same work.
3. The standard library does the work.
4. A native platform feature does the work.
5. A dependency that the project already uses does the work.
6. The code can be shorter with the same logic.

Before you flag a cut, make sure that nothing references the code through a dynamic call, a config file, or a public API.

## Skip

- Input validation at trust boundaries.
- Error handling that prevents data loss.
- Security measures.
- Accessibility basics.
- Calibration values for real hardware.
- Code that the user explicitly requested.
- Correctness bugs, security holes, or performance problems. Route them to a review.
- Structural smells that do not remove code, such as unclear names. Route them to `/refactor-audit`.

## Groups

Order the groups by the size of the cut, biggest first. Order the findings inside a group the same way.

| Tag | What it covers |
|-----|----------------|
| `delete` | Dead code, or a speculative feature that nothing uses |
| `stdlib` | Code that reinvents the standard library |
| `native` | A dependency that does what the platform does |
| `yagni` | An abstraction with one implementation, a factory for one product, a setting for a value that never changes |
| `shrink` | The same logic with fewer lines |

## Columns

In the `Cut` column, write the lines or dependencies that the change removes. Count the lines from the `path:line` range. Count a dependency as one manifest entry. If you cannot count, write `?`.

```
## 1. yagni

| # | Where | What to cut | Replacement | Cut |
|---|-------|-------------|-------------|-----|
| 1.1 | src/store.ts:10-85 | StoreFactory builds one Store | Call new Store directly | 75 lines |

## 2. native

| # | Where | What to cut | Replacement | Cut |
|---|-------|-------------|-------------|-----|
| 2.1 | package.json:14 | date-picker library | input type="date" | 1 dependency |
```

## Close

```
total: <M> findings across <K> groups. Net: <N> lines and <D> dependencies removable.
```

No findings: `Lean already. Ship.`

## Brief

- The change must keep the behavior the same.
- The subagent edits the dependency manifest.
- The subagent does not edit a lockfile and does not run an install.

## Summary

- The commands that the user must run to refresh lockfiles, if a dependency was removed.

## Extra files

Read the dependency manifests, for example `package.json`, even when they are outside the scope. Dependencies can be cut when the scope is small.
