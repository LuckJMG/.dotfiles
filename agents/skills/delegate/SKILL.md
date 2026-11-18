---
name: delegate
description: Choose the model and effort for a subagent before you start it, and adjust them after a result. Works for any model provider. Use before you delegate a task, and when a subagent result misses the mark or gives more than you need.
---

# Delegate

Two settings control a subagent:

- **Model** sets capability: the knowledge, reasoning, and judgment that the model brings. The brief can steer a model, but it cannot add to what the model knows.
- **Effort** sets thoroughness: how long the model thinks, how many files it reads, how much it verifies, and how far it goes before it reports back.

Map the models that you have to four tiers. Use price and speed to sort them. A more capable model costs more for each token and is slower.

| Tier | Use for |
|---|---|
| frontier | Long-horizon, open-ended, or unsolved problems. Use it only when the strong tier falls short. |
| strong | The default. Complex coding, analysis, and work that needs judgment. |
| mid | Everyday work with a clear scope: code edits that you can describe precisely, documents, data analysis. |
| small | High-volume, bounded work with a clear correct output: classification, extraction, routing, search, summaries. Do not use it for complex work. |

If the model has no effort setting, use the thinking budget. If the model has no thinking budget either, put the effort in the brief, for example "run the tests before you report".

## Choose

1. Use only the models and providers that you have access to. Do not change the provider unless the user asks.
2. Answer two questions about the task:
   - How long would the task take a human without AI?
   - How clear is the correct output?
3. If the task is short and the correct output is clear, use the lowest tier that can do it.
4. If the task is long, ambiguous, or needs judgment throughout, use the strong tier.
5. If you are not sure, use the strong tier. A failure on a small model is hard to separate from a failure in the brief.
6. Start at the default effort of the model.
7. Write a more specific brief for a lower tier. Lower tiers need exact instructions. Higher tiers handle ambiguity better.
8. If you run the same task many times, run two or three samples on the lower tier first. Compare them with the higher tier before you run the batch.

Compare the cost for each task, not for each token. On long or hard work, a more capable model often finishes in fewer turns and costs less in total. On routine work, a lower tier gives the same result for less money.

High stakes, output that is hard to verify, and tight latency also change the choice. Move up a tier for the first two. Move down a tier for the third.

## Adjust after a result

1. If the result is wrong, first make sure that the brief gave all the needed context and tools. If it did not, fix the brief and keep the settings.
2. Change one setting at a time, so that you know which change worked. Change effort before the model.
3. Ask: did the subagent not try hard enough, or did it not know enough?
4. If it did not try hard enough, raise effort. Signs: it skipped a file, did not run the tests, missed instructions, or stopped before the end.
5. If it did not know enough, use the next higher tier at the default effort. Signs: it had all the context, it clearly tried, and it is still wrong. Subtle bugs, unfamiliar domains, and architecture decisions often need a higher tier.
6. If the output is verbose or goes past the scope, lower effort. To save cost, lower effort before the model. Lower effort keeps the judgment of the model.
7. If the quality stays good at lower effort, try a lower tier. Compare the results before you rely on the lower tier.

Effort shapes the token use but does not limit it. To limit the output, state a length or a scope in the brief.

## Combine tiers

- **Orchestrator and workers**: a strong model plans and reviews. Lower-tier subagents do the bulk work.
- **Executor and advisor**: a lower-tier subagent does the task. It sends hard decisions, plans, or final checks to a strong model.

Both patterns bill most tokens at the lower rate and keep strong judgment where it matters.
