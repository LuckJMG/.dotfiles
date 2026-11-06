---
name: data-storytelling
description: Rules to communicate with data, based on "Storytelling with Data" by Cole Nussbaumer Knaflic. Use when you make or review a chart, graph, table, slide, slide deck, dashboard, or report that shows data to an audience. Covers context, choice of visual, clutter, focus of attention, design, and story structure. Use it together with plotting code in any tool (matplotlib, plotly, ggplot, Excel, D3, and others).
---

# Data storytelling

These rules come from *Storytelling with Data* (Cole Nussbaumer Knaflic). They apply to explanatory visuals: a visual that tells an audience one specific thing. They do not apply to exploratory analysis, where you look at data to find what is interesting.

Do the six steps in order. Do not start with the tool or the chart type.

## Step 1: Understand the context

Before you make a visual, answer these questions. If the user did not give the answer and you cannot find it, ask the user.

1. **Who** is the audience? Name one specific audience, for example the decision maker. Do not write for "all stakeholders".
2. **What** must the audience know or do? Write the action with a verb (approve, change, invest, stop).
3. **How** will the audience get the content?
   - Live presentation: you control the order. Keep slides sparse. The speaker gives the detail.
   - Written report or email: the reader controls the order. Put more detail and explicit text on the page.
4. **Tone**: Is it a success, a warning, or a neutral status? The tone sets color and words.
5. **Data**: Which data supports the point? Include data that goes against the point too. A one-sided story loses credibility.

Then write two items:

- **Big Idea**: one complete sentence. It gives your point of view and what is at stake. Example: "The pilot program improved student perceptions of science, so approve the budget to continue it."
- **3-minute story**: one paragraph that tells the full message without slides.

If you cannot write the Big Idea, you do not know the message yet. Do not make the visual.

For a deck or report, make a storyboard first. Write one headline per slide or section as plain text. Agree on the order with the user before you make the content.

## Step 2: Choose the visual

Use the visual that is easiest for the audience to read. Prefer a familiar type. The audience then spends effort on the message, not on how to read the chart.

| Data and goal | Use |
|---|---|
| One or two numbers | Simple text: the number, large, with a short sentence. No chart. |
| Many values, mixed audience, each reader looks up a different row | Table with light or no borders |
| Table where the reader must find high and low values | Heatmap: one color, saturation shows magnitude, with a legend |
| Relation between two variables | Scatterplot |
| Trend over continuous time | Line graph |
| Change between two points in time across categories | Slopegraph |
| Comparison across categories | Bar chart. Horizontal bars are the default, mainly for long labels. |
| Totals and their parts | Stacked bar. Compare only the bottom series and the total. |
| Parts of a whole on a negative-to-positive scale (Likert data) | 100% stacked horizontal bar |
| Start value, additions, subtractions, end value | Waterfall chart |
| Values of very different magnitudes | Square area chart (the only area chart to use) |

Rules for the chart types:

- **Bar charts**: always start the axis at zero. Make bars wider than the gaps between them.
- **Line graphs**: a nonzero baseline is permitted. Say so, and do not zoom so far that small changes look large.
- **Time axis**: use equal intervals. Do not mix decades and years on one axis.
- **Forecast**: show actual data as a solid line and forecast as a thinner dashed line. Label the two parts.
- **Range**: to show an average with a range, show the range as a light band around the line.
- **Category order**: use the natural order if one exists (age groups, Likert scale). Otherwise, sort by value. Put the most important category at the top.
- **Multiple series**: use them with caution. Each series makes one comparison harder.

Do not use these:

- **Pie and donut charts**. People cannot compare angles, areas, or arc lengths. Use a horizontal bar chart, simple text, a 100% stacked bar, or a slopegraph.
- **3D**. It distorts values. The only exception is real three-dimensional data.
- **Secondary y-axis**. Label the second series directly, or put two graphs one above the other with a shared x-axis.
- **Different chart types or colors only for variety**. Keep the same form for the same kind of data in one deck or report.

## Step 3: Remove clutter

Each element adds cognitive load. Remove each element that does not add information. Test each element: if you remove it, does the audience lose something? If not, remove it.

Remove or reduce these defaults of the plotting tool:

1. Chart border and background color.
2. Gridlines. If you must keep them, make them thin and light grey.
3. Data markers on each point of a line. Keep markers only on points that you discuss.
4. Trailing zeros and unnecessary decimals on axis labels and data labels.
5. Diagonal text. Abbreviate the labels or use horizontal bars so that the text is horizontal.
6. The legend. Label each series directly at the end of the line or next to the bar, in the color of the series.
7. Redundant axes. If you label each data point, remove the axis.

Keep these, because they are not clutter:

- Units on each number: `$`, `%`, and thousands separators.
- A chart title and axis titles (see step 5).

Use the Gestalt principles to remove more elements:

- **Proximity**: put labels next to the data that they describe.
- **Similarity**: give a label the same color as its data. Use color across a table row instead of borders.
- **Enclosure**: use light shading to separate a region, for example a forecast period.
- **Closure** and **continuity**: the chart looks complete without a border or an axis line.
- **Connection**: use lines only to connect ordered data, such as time.

Layout:

- Left-align text. Do not center-align text. Make clean vertical and horizontal lines of elements.
- Keep white space. Keep margins empty. Do not stretch a visual to fill the space. Do not add data because space is free.
- If one thing is very important, make it the only thing on the page.

## Step 4: Focus attention

Readers see preattentive attributes before they read: color, size, position, bold, enclosure, added marks. Use them sparingly, on at most about 10% of the visual. If everything is different, nothing stands out.

Method:

1. Make everything grey first.
2. Choose what the audience must see. Give only that element a strong color, more line thickness, a data marker, a data label, or bold text.
3. Do the "where are your eyes drawn?" test. Look away, look back, and note where your eyes go first. If it is not the key point, change the emphasis.

Color rules:

- Use grey for the base. Use one bold color for emphasis. Blue is a good default: it prints well in grayscale and works for colorblind readers.
- Use color only when it has a purpose. Do not accept the tool default palette.
- Do not use a rainbow palette. For magnitude, use saturation of one color.
- Use color consistently. If a category has a color on one slide, keep that color on all slides. Do not use that color for something else.
- Do not use red and green together. About 8% of men are colorblind. For positive and negative, use blue and orange. Alternatively, add a second cue: bold, a `+` or `−` sign, or saturation.
- Match the tone. Use muted colors for a serious topic and bright colors for a light topic.
- With brand colors, use one or two brand colors for emphasis and grey for the rest. If the brand color has low contrast, use black or another color for emphasis.
- Prefer a white background. On a dark background, reverse the logic: black is the base and white or bright colors stand out.

Size and position:

- Size shows importance. Give items of equal importance equal size.
- Readers scan from the top left in a "z" pattern. Put the most important item (the takeaway or the call to action) at the top. Put the chart title, legend, and axis titles at the top left, so the reader knows how to read the chart before the data.
- Put negative values on the left and positive values on the right.

Text emphasis:

- Prefer bold. Use italics for mild emphasis. Do not underline.
- Use uppercase only for short labels.
- Do not change the font to show emphasis.
- Use one font size for all text, except where you decide otherwise: a larger title, a smaller footnote.
- Use dark grey for titles and normal text. Keep black for emphasis.

## Step 5: Design for the audience

**Text is your friend.**

- Give every chart a title and every axis a title. Exceptions are very rare.
- Write the conclusion in words. Two readers can take different conclusions from the same chart.
- Use an action title on a slide or chart: "Estimated 2015 spending is above budget", not "2015 Budget".
- Annotate important points on the chart: the reason for a peak, an external event, a nuance.
- Put the data source and notes in a small grey footnote at the bottom.

**Do not overcomplicate.**

- Use simple words and short sentences. Spell out each acronym at first use.
- Use a consistent, easy-to-read font.
- Summarize when the audience does not need the detail. Move the detail to an appendix.
- Round numbers to the precision that the audience needs.
- Use super-categories (for example age, income, region) to group many rows.

**Make it look good.** Readers give more time to a visual that looks careful. Check color, alignment, and white space again.

**New formats.** If the audience is used to an old format, show the old and new versions side by side and give the benefits of the new version.

## Step 6: Tell the story

Structure every communication with a beginning, a middle, and an end.

- **Beginning**: the setting, the main character (the audience), the imbalance (what changed or what is the problem), and the desired state. Tension between "what is" and "what could be" makes the audience care.
- **Middle**: evidence, context, comparisons, options, the cost of no action, and the benefits of your solution. Frame it in terms of what motivates the audience.
- **End**: a clear call to action. Tie it back to the problem from the beginning.

Order:

- **Chronological**: use it when you must build credibility or when the audience cares about the process.
- **Lead with the ending**: use it when the audience trusts you and wants the answer. Start with the call to action, then give the support.

Repetition: tell the audience what you will tell them, tell them, then summarize. In a deck, use an executive summary at the start and a recap at the end.

Presentation versus document:

- **Live**: show one point at a time. Show the empty chart first and explain the axes. Then add or highlight one series per slide. Keep the base visual the same, and move only the emphasis.
- **Written or sent after the meeting**: use one fully annotated visual that explains itself without a speaker.
- Do not use slides as speaker notes. Put on the slide only what supports the spoken words.
- Do not put a full table on a slide. Show the point. Put the table in the appendix.

**Spaghetti graph** (many lines that overlap):

- Highlight one line at a time and make the others grey.
- Alternatively, split the lines into small charts with a shared axis.
- Alternatively, combine the two: small charts, each with one highlighted line and the others grey.
- Ask if the audience needs all categories and all periods. Show less data if possible.

## Final checks

Before you deliver, make sure that each item is true:

- [ ] You can say the Big Idea in one sentence, and the visual supports it.
- [ ] The chart type is the simplest that shows the point. No pie, donut, 3D, or secondary y-axis.
- [ ] Bar charts start at zero. Time intervals are equal.
- [ ] No border, heavy gridlines, default markers, diagonal text, or legend that a direct label can replace.
- [ ] Everything is grey except the one point of emphasis.
- [ ] The eye goes first to the key point.
- [ ] Chart title (an action title where possible), axis titles, units, and source are present.
- [ ] Text is left-aligned and elements align on clean lines. Margins are empty.
- [ ] Colors are consistent across all visuals and safe for colorblind readers.
- [ ] Deck: the slide titles alone tell the story (horizontal logic). Each slide's title, text, and visual support one point (vertical logic).
- [ ] Deck: write down the main point of each slide. The list matches the storyboard (reverse storyboarding).
- [ ] For a live presentation, slides are sparse. For a document, the text explains the "so what" without a speaker.

If you can, render the visual and look at it. Describe where the eye goes first, what you see, and what questions a new reader can have. Fix the visual before you deliver it.
