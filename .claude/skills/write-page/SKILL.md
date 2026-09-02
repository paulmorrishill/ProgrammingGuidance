---
name: write-page
description: Write a new page for the Programming Guidance site. Use when asked to write, draft or add a page, article or topic to the site, or when a review finds a missing prerequisite page. Establishes prerequisites first, verifies facts with subagents, drafts to the fixed shape, adds glossary terms, then runs the gates and the content review.
---

# Writing a page

The rules live in `STYLE.md` and the checks live in
`.claude/skills/content-review/references/rubric.md`. Read `STYLE.md` before drafting.
This skill is the order of work, not a second copy of the rules.

`references/page-template.md` holds the skeleton and the front matter.

## The five that decide whether the page is worth publishing

1. **Concepts, not keystrokes.** If the reader reaches the same result by asking their
   AI, cut it. Keep only what costs money, data or a security breach when wrong.
2. **The reader knows nothing.** Every technical word is in `_data/glossary.yml` or
   defined in the prose at first use. Include ordinary words used in a specific sense.
3. **Never simplify into a falsehood.** Use the correct name, then explain it.
4. **Say what a thing is.** A definition that pivots to another subject has defined
   nothing, and contrast for rhythm is not information.
5. **Name what the reader decides.** A page that explains a concept without saying
   what judgment stays with the human is documentation, and this site is not that.

`CLAUDE.md` governs what you write to the user. `STYLE.md` governs what goes on a
page. Do not put the labels from `CLAUDE.md`, such as `FACT:`, into page content.

## Step 1. Place the page

Read the front matter of the existing pages to see the sequence. Decide the tier and
where the page sits in the order.

Ask the user with AskUserQuestion when the tier or the position is genuinely open. Do
not ask when the answer follows from the dependencies.

## Step 2. Establish the prerequisites, and stop if one is missing

List the concepts the page must assume. For each, find the page that teaches it.

**If a concept has no page, say so and stop.** Offer to write that page first. A page
whose prerequisite does not exist teaches nobody, and the build rejects a `requires`
entry that names no page.

The data types page needed variables and values first, because a reader who does not
know what a value is cannot learn what kind a value has.

## Step 3. Collect the vocabulary before drafting

List every term the page will use. Sort each into one of three:

- Already in `_data/glossary.yml`. Use the term and rely on the tooltip.
- New, and load-bearing. Add it to `_data/glossary.yml` in this step, before drafting.
- Explained by this page. The page is its definition, so write it in the prose.

Never write the glossary sentence into the page as well. The build fails on that, and
the two copies drift.

## Step 4. Verify the facts before drafting

Wrong claims are the worst failure this site can produce, because the reader has no
way to detect one.

Where the page makes claims about specific languages, runtimes or standards, spawn one
`general-purpose` subagent per language, in a single message, with this prompt:

> For the Programming Guidance site, establish what is true about <TOPIC> in <LANGUAGE>.
>
> Return only claims you have verified, each in one sentence, with the mechanism.
> State the type or feature by its correct name. Where a common simplification is
> wrong, say what is wrong with it.
>
> Cover: the types or features involved, the traps a beginner meets, and the one thing
> the language does differently from the others. Note anything version dependent, with
> the version.
>
> Do not write prose for the page. Return facts.

Read every result and resolve disagreements yourself. A subagent that sounds confident
is not therefore correct.

## Step 5. Draft

Follow `references/page-template.md`.

Write the definition first, before anything else on the page. If you cannot write it
in two sentences, you do not yet understand the topic well enough to teach it.

Add a diagram wherever the idea has a shape: a boundary, a sequence, a decision, two
things that differ. Label every edge with a verb, keep it under 7 nodes, and write one
line after it saying what to notice.

Include the language accordion only where the languages genuinely differ in a way that
changes what the reader does. Cover all five or none.

## Step 6. Check your own draft

Read the draft once as somebody who has never programmed, and once against the rubric
sections for factual accuracy, undefined jargon, mechanical content and empty
sentences.

Then run:

```bash
bundle exec rake check
```

Fix what it reports and run it again.

## Step 7. Review

Run the `content-review` skill on the new page. Report its findings to the user before
applying them.

## Step 8. Wire it in

The index and the "Read first" and "Next" links come from the front matter, so there
is nothing to write by hand. Confirm the page appears in the right place, then add its
link to the "Next" list of the page before it.
