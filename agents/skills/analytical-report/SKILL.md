---
name: analytical-report
description: Structure and clarity rules for an analytical report that answers one question with data, such as a university data project, a model study, or a technical analysis. Use when the user asks to write, outline, restructure, or review such a report. Covers the section skeleton, the abstract, the main question and main idea, how to present each figure, table, and decision, robustness, conclusion, and appendix.
---

# Analytical report

These rules give a report one line of argument from the question to the answer. The reader must always know why a section exists, what each figure shows, and why each decision was made.

Write the report in the language that the user asks for. If the guideline of the course or of the document requires something else, follow the guideline.

## Before you write

Get these facts from the user or from the sources. If a fact is missing, ask for it. Do not invent it.

- The main question, in one sentence.
- The data: source, author, period, unit of observation, number of records.
- The method and the reason for it.
- The order of the work, for example the cells of the notebook.
- The previous feedback, if the report follows a proposal or a draft.
- The results, with their numbers.

## Skeleton

Use this order. Remove a section that does not apply. Rename sections to fit the topic. Start each numbered section on a new page.

1. **Title page.** Title, a subtitle that names the object, the scope, and the period, then the authors and the date.
2. **Abstract.** One paragraph with what the report studies, the data with its size and source, the variables that the authors built, the method, the main result with its metric, and the robustness checks with their numbers. Then a table of contents.
3. **Introduction.** Write these parts in order:
   1. The context: what the data records and why it matters.
   2. The data: source, period, and number of records.
   3. The previous feedback and what changed. Add a table with two columns: "Observation" and "Where the report addresses it".
   4. The main question, alone and highlighted.
   5. The method in one paragraph: its input, its output, and who can use the answer.
   6. The main idea: the answer in one sentence, highlighted. The conclusion repeats it word for word.
   7. A map of the report: which sections do what, and the tools used.
4. **Data description and cleaning.** State what one row is. Give a table of the variables with name, type, and description. Give each quality check as a list item with its number and its consequence: missing values, duplicates, inconsistent names. Show the coverage over time and the distribution of the main measure. End with the cleaning decision and its reason.
5. **Exploration.** One section for each sub-question that leads to the model. If the authors dropped a part of the original question, give a section with the evidence for that choice.
6. **Built variables.** If a variable does not come in the data, explain how the authors built it. Give the rules in order, the code if it is short, how the authors validated it, a summary table, and its limitation.
7. **Model variables.** Change the unit of analysis if the question needs it. Define each variable with a formula and the dimension of the question that it measures. Justify each discarded variable with a number, for example a correlation.
8. **Model.** Explain why this family of models fits the problem. Give the preprocessing and its reason, how the method works in one paragraph, the criteria for each parameter in a table with the chosen value highlighted, and a comparison with a second method.
9. **Results.** Give the rule that names each result, for example a group. Give a profile table with the defining value highlighted, then one list item for each result with its numbers. Report the quality of each result, and name the weakest one. Give concrete examples.
10. **Robustness.** One subsection for each check. Give the number, what changes, and why. Close the open points from earlier sections here.
11. **Conclusion.** Answer the question directly, with the main metrics. Say what distinguishes the results. Repeat the main idea. Give a numbered list of limitations and a numbered list of next steps.
12. **Appendix.**
    - The theory of each method: the formula, a "Where:" list for the symbols, how to read the value, and the library function that computes it.
    - The design decisions for the charts.
    - Questions and answers: the questions that an evaluator can ask, each with a short answer.
    - Reproducibility: the files, the order of execution, the random seeds, and the outputs.
13. **Bibliography.** Include the data source and each method that the report cites.

## Clarity rules

### Sections

1. Open each section with the question that it answers or its link to the previous section.
2. Follow the order in which the work was done. The reader can then match the report with the code.
3. Write a subsection heading as a question when it justifies a choice. For example: "Why did we not use the total amount?"
4. Refer to other parts by number: "section 9.3", "appendix 1.5". If a section finds a problem that a later section resolves, say so in both places.
5. Keep the theory in the appendix. In the body, give the idea in one sentence and the reference to the appendix.

### Figures and tables

6. Before each figure or table, say what it shows. If a design choice is not obvious, give the reason, for example why only one element has color.
7. After each figure or table, write its reading in this order: the numbers, what they mean, the consequence for the next step. Connect the consequence with "so" or "for this reason".
8. Write the chart title as a sentence with the conclusion. Write the caption as what the chart measures, with its units.
9. Draw the context in gray and only the element that supports the title in color. Label the data directly and remove legends, borders, and grids that the reader does not need.
10. Use a table when the reader needs exact values. Use a chart for a pattern. Say which one you chose when the choice is not obvious.
11. Highlight in each table only the row or cell that supports the argument.
12. Give each entity one name and one color in every table, figure, and paragraph.

### Decisions and claims

13. Give each decision with its reason and the number that supports it.
14. Mark decisions and limitations with a bold label at the start of the paragraph: "**Cleaning decision.**", "**Limitation.**".
15. Give each number with its unit and its base: "31 of the 38 members", "51% of the 1,980 records".
16. Bold the one key fact of a paragraph, at most one per paragraph.
17. Interpret each metric with a published threshold, and cite it. For example, a silhouette between 0.26 and 0.50 indicates a weak structure (Kaufman and Rousseeuw, 1990).
18. Report weak results as they are. Name the weak part, give its number, and say which check confirms it.
19. If the data does not explain a pattern, say so. Do not invent a cause.
20. Use the same numbers in the report, the code, and any slides. Export them from one source, such as a JSON file that the code writes.

### Prose

21. Give each paragraph one thread. Connect each sentence to the previous one with a cause or consequence, so the paragraph does not read as a list.
22. Use one term for each concept in the whole report. Define an acronym at its first use.
23. Match the strength of each claim to its evidence. Use "always" or "never" only when the data proves it.
24. Delete each sentence that does not help the reader follow the argument.

## Final check

Before you call the report finished, make sure that:

- The main idea appears in the introduction and, word for word, in the conclusion.
- Each item of previous feedback appears in the feedback table with its section.
- Each figure and table has an introduction, a caption, a number, and a reading.
- Each decision has a reason and a number.
- Each forward reference has a matching section.
- Each method in the body has its theory in the appendix and its reference in the bibliography.
- The numbers in the abstract, the body, and the conclusion are equal.
