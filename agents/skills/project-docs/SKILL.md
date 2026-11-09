---
name: project-docs
description: Write or update project documentation with the templates and practices of The Good Docs Project. Use when the user asks for a README, how-to, tutorial, concept, reference, API reference, API getting started, quickstart, installation guide, troubleshooting, runbook, changelog, release notes, glossary, contributing guide, code of conduct, bug report template, style guide, SDK overview, user personas, or other project docs. Also use when the user says "Good Docs", "TGDP", or "docs template".
---

# Project docs

This skill writes project docs from the templates of The Good Docs Project (TGDP). The templates are in the `templates/` directory next to this file. That directory is a git submodule of `https://gitlab.com/tgdp/templates`.

If `templates/` is empty, tell the user to run `git submodule update --init` in the repository that contains this skill.

## Files for each doc type

Each doc type has a directory in `templates/`, for example `templates/how-to/`. The file `templates/index.json` lists each doc type with its `name`, `summary`, `packs`, and `files`. The `files` object can contain these keys:

| Key | Use |
|-----|-----|
| `template` | The structure of the doc. Placeholders are in `{curly brackets}`. |
| `guide` | How to fill in each section of the template. |
| `process` | How to research, write, and maintain this doc type. |
| `resources` | External links. Read only if the guide does not answer a question. |
| `example` | A completed doc. Use it as a model for depth and tone. |

## Procedure

1. Read `templates/index.json`. Find the doc type that matches the request.
2. If no type matches, or more than one type matches, ask the user. The guides explain the differences, for example between a how-to and a tutorial.
3. Read the `guide` file of the type from start to end.
4. If the type has a `process` file or an `example` file, read it.
5. Read the project: code, existing docs, build files, and git history. Collect the facts for each section.
6. If a fact is not in the project, ask the user. Do not invent versions, commands, URLs, names, or support contacts.
7. Ask the user where to write the doc, unless the project already has a clear place. For example, a README goes at the repository root as `README.md`.
8. Copy the structure of the `template` file. Keep the order of its sections.
9. Replace each `{placeholder}` with project text. Delete optional sections that do not apply.
10. Delete the instruction blockquote at the top of the template.
11. Apply the writing rules in the next section.
12. Make sure that no `{placeholder}` text stays in the doc. Do not count braces in code blocks.

If the user asks to update an existing doc, compare it to the template and the guide. Report the missing sections and the deviations, and then edit.

## Writing rules

The guide of the doc type sets the sections and their content. The writing style sets the wording.

1. If the user or the project configures a writing style, use that style. Examples are a style rule in the agent instructions, a style skill, or a style guide or Vale config in the project.
2. If no style is configured, use the TGDP rules:
   - Read `templates/writing-tips.md` before you write. It covers language, procedural steps, page structure, titles, and filenames.
   - Use these sections of `templates/STYLE-GUIDE.md`: "Write for the audience", "Be consistent", "Abbreviations", "Plain language", "Capitalize consistently", "Information organization", "Links", "Lists", "Tables", and "Notes". The other sections are for TGDP template authors. Ignore them.

## Update the templates

Run this command in the repository that contains this skill to get the latest templates:

```sh
git submodule update --remote <path-to-skill>/templates
```
