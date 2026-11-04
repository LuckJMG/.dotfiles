---
name: audit
description: Scan code for one kind of problem, report the findings, wait for approval, then apply the approved findings. Use for any audit, for example performance, bugs, or accessibility. The commands /refactor-audit and /overengineering-audit use this skill with a fixed audit context.
---

# Audit

This skill defines how an audit runs. The audit context says what to hunt for, how to group and show the findings, and what to tell the subagents.

Scan the code. Report the findings. Wait for approval. Apply only the approved findings.

## Audit context

The audit context has these items.

| Item | What it defines |
|------|-----------------|
| `Hunt` | What to look for in the scan, and the checks to run on each candidate |
| `Skip` | What the scan must not flag |
| `Groups` | The tag for each group of findings, with what each tag covers, and how to order the groups |
| `Columns` | The columns of the report table, with one example |
| `Close` | The last line of the report, and the line for no findings |
| `Brief` | Extra rules for the subagent briefs, including whether a change can alter behavior |
| `Summary` | Extra lines for the final summary |
| `Extra files` | Extra files to read even when they are outside the scope (optional) |

### Source of the context

If a command supplied the context, use it. If an item is missing, stop and tell the user which item is missing.

If no command supplied the context, the user asked for an audit directly. Build the context from the request:

1. Separate the kind of audit from the scope text. For example, in "performance audit of src/api", the kind is performance and the scope is `src/api`.
2. Write every item of the context for that kind of audit. In `Brief`, state whether a change can alter behavior. A bug fix can alter behavior. A refactor cannot.
3. Print the context in the same item order as the table.
4. Ask the user to approve the context. Do not scan before the user answers.
5. If the user asks for a change, change the context and ask again.

If the kind of audit is unclear, ask the user. Do not guess.

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

Skip generated code, build output, vendored dependencies, lockfiles, and deleted files. Read the `Extra files` from the context, if any.

Print the resolved scope in one line: the rule that you used and the number of files.

---

## Phase 2: Scan

Use `Read`, `Grep`, and `Glob` to inspect the files. Follow `Hunt` from the context. Do not flag anything in `Skip`.

Read the callers and importers of each candidate. A unit can look unused or duplicated inside a diff and be used outside the scope.

Note the exact `path:line` and the unit name for each finding. If you cannot make sure that a finding is correct, do not report it.

---

## Phase 3: Report

Group the findings with the tags in `Groups`. Print only the groups that have findings. Number each group (1, 2, 3, …) in the order that `Groups` states. Number each finding inside a group as a minor of that number. For example, `2.3` is the third finding in the second group.

Use one table for each group, with the heading `## <number>. <tag>`. Use the columns from `Columns`. Keep each cell to one logical line. State each problem as a fact. State each fix as a direction, not a full plan. Do not invent numbers.

End the report with the `Close` line. If you find nothing, print the no-findings line from `Close` and stop. Do not invent findings.

Then ask the user which findings to apply. Accepted answers:

- `all`
- a list of IDs, for example `1.1 2.3`
- a group number, for example `2`
- `none`

---

## Phase 4: Wait for approval

Stop after the question. Do not change any file before the user answers.

If the user picks a subset, apply only that subset. If the user asks to change a finding, change the finding and ask again. If the user answers `none`, stop.

---

## Phase 5: Apply

Delegate the approved findings with the `Agent` tool. Use one subagent for each approved group.

The subagent has no audit context. Write each brief so that it stands alone:

- the tag and what it means
- the list of approved findings, with every table cell for each finding
- the rule that the subagent changes only the listed findings
- the rule that the subagent follows the existing style of the repo
- the rule that the subagent does not commit
- the rules from `Brief`
- the request for a summary of the files that it changed

Rules for the run:

- If two groups touch the same file, run those subagents one after the other. Run the other subagents at the same time.
- If a subagent finds that a finding is wrong or unsafe, it must skip the finding and say why.
- Do not let a subagent widen the scope. New problems go in the summary as new findings.

After all subagents finish, run `git diff --stat`. Print this summary:

- the findings that were applied
- the findings that were skipped, with the reason
- the new findings that the subagents reported
- the lines from `Summary`

Do not commit. The user decides when to commit.

---

## Boundaries

- The audit is a snapshot. If the repo changes, run the command again.
- Do not apply a finding that the user did not approve.
