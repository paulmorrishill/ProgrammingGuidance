# Writing style guide

This applies to every page on this site.

## Reader

Someone who builds apps with AI help and wants to ship them. They write code that
runs. They have gaps in the ideas underneath the code.

Assume:

- They can read code.
- They have not read the docs.
- They skim first and read second.
- English may be their second language.

Do not assume:

- They know any acronym.
- They know why a thing exists.

## Base standard

Pages follow ASD-STE100 Simplified Technical English in STE-flavored mode.
Structural rules are mandatory. Lexical rules are a direction of travel, not a
checkable standard, because the official 900-word dictionary is not reproduced here.

Reference: the `asd-ste100` skill at `~/.claude/skills/asd-ste100`.

### Mandatory rules

1. Active voice. "Git stores the file." Not "The file is stored by Git."
2. One idea per sentence.
3. Maximum 20 words in an instruction. Maximum 25 words in a description.
4. No semicolons. Split the sentence instead.
5. No phrasal verbs. Write "start", not "spin up". Write "remove", not "take off".
6. Simple tenses. Write "we received the file", not "we have received the file".
   Keep the compound form only when it carries current relevance.
7. Maximum 3 words stacked in a noun phrase.
8. Keep hedges. "May fail" does not become "fails".
9. Maximum 6 sentences per paragraph. One topic per paragraph.
10. Use a list for 3 or more steps or conditions.

### One word, one meaning

Choose one word for one thing. Repeat it. Do not rotate synonyms.

- Use "repository" every time, or "repo" every time. Never both on one page.
- The same rule applies to user, customer, and client.

Define a glossary term once. Then reuse the exact term.

## Concise

Cut words until the next cut loses meaning. Then stop.

Delete:

- "It is important to note that"
- "basically", "simply", "just", "actually"
- "In this section we will look at"
- Marketing adjectives: seamless, powerful, robust, blazing-fast, cutting-edge
- Any sentence that announces what the next sentence says

Prefer:

- A verb over a noun. "Analyze the log", not "perform an analysis of the log".
- A number over an adjective. "3 seconds", not "slow".
- An example over an explanation, when both fit.

Compression is not the goal. Clarity is. Stop when the sentence has one meaning,
not when it is shortest.

## Page shape

Every topic page uses this order:

1. **Title** — a question or a noun. Example: "What is Git".
2. **Definition** — 1 or 2 sentences. The first line on the page.
3. **The problem** — the concrete failure this thing prevents.
4. **Mental model** — one picture the reader can hold.
5. **The parts** — named concepts, one short block each.
6. **Do this** — the smallest set of commands or steps that works.
7. **Common mistakes** — real failures, not theory.
8. **Next** — 2 or 3 links.

Skip a section when it has nothing to say. Do not pad it.

## Jargon

Define a term the first time it appears, in the same sentence.

- Yes: "A commit is one saved checkpoint of your project."
- No: "Commit your work to the index before you push."

After the definition, use the term. Do not explain it again.

## Code

- Tag every code block with its language.
- Comments explain why, not what.
- Show the output when the output matters.
- Use real code, not pseudocode.

## Claims

- State a fact or state nothing.
- Name the consequence when a thing is unsafe.
- Do not soften a warning to sound friendly.
- Give the version or the date for anything that changes.

## Tone

Flat and direct. No jokes about how confusing the topic is. No apology for the
reader's level. Respect the reader by not wasting their time.

## Checklist before publish

- [ ] Every sentence is 25 words or fewer
- [ ] No semicolons
- [ ] Active voice throughout
- [ ] Every term defined on first use
- [ ] No filler words from the list above
- [ ] One name per concept
- [ ] Code blocks tagged, commands tested
- [ ] The page opens with the definition, not a preamble
