---
description: Rewrite AGENTS.md so that it keeps only the context that an agent cannot get from the code. Optional path argument.
allowed-tools: Read, Grep, Glob, Edit, Write, Bash(git:*), Bash(ls:*)
---

Rewrite the AGENTS.md file. Keep only the facts that an agent cannot find with a quick read of the repository.

Target: $ARGUMENTS

If the target is empty, use `AGENTS.md` in the repository root. If the file does not exist, stop and tell the user.

## Read

1. Read the target file.
2. Read `CLAUDE.md`, `GEMINI.md`, and `README.md` if they exist. They can contain facts that belong in AGENTS.md.
3. Read the repository layout, the manifests, the build files, and the CI config.
4. Read `git log --oneline -50`. Look for fixes that show a trap.

## Test each fact

For each fact in the file, ask: "Can an agent find this in two minutes with `ls`, `grep`, or one file read?"

- If yes, delete the fact.
- If no, keep the fact.
- If the code contradicts the fact, fix the fact or delete it. Do not keep a stale fact.

### Keep

- **Architecture that the code does not show**: why a boundary exists, how parts talk across processes or repositories, which part owns which data.
- **Invariants and decisions**: rules that the code obeys but does not state, and the reason for each rule.
- **External context**: submodules and their upstream, services, deploy targets, manual install steps, required credentials (names only, never values).
- **Non-default commands**: build, test, lint, or run commands with required flags, a required order, or a required environment.
- **Traps**: stale docs, hardcoded values, files that a tool generates, files that must not be edited, commands that destroy data.
- **Conventions that a linter does not enforce** and that differ from the language default.

### Delete

- Directory trees and file lists that `ls` shows.
- Descriptions of a file that its name or its first lines show.
- Generic advice, for example "write clean code" or "add tests".
- Language or framework defaults, for example `npm install` in a Node project.
- Copies of README content with no agent-specific value.
- Rules that already live in the global agent instructions of the user.

## Write

- Use the shortest form that keeps the fact. Prefer one line per fact.
- Group facts under short headings. Use only the headings that have facts.
- Put commands in code blocks.
- Do not add a fact that you did not make sure of in the code or the git history.
- Do not change the meaning of a rule that the user wrote. If you are not sure that a rule is still true, keep it and list it in the report.

## Report

After the edit, show:

1. `git diff --stat` for the target.
2. A list of the deleted facts, each with the reason in five words or fewer.
3. A list of the facts that you added, each with its source.
4. A list of the facts that you are not sure of.

Do not commit.
