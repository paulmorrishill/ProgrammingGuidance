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

## Glossary terms

Every load-bearing term is defined once, in `_data/glossary.yml`. Nothing else
defines it.

The site links the first mention of each term on a page, shows the definition on
hover, and sends a click to the page that teaches it. Authors write plain prose and
mark nothing.

### Adding a term

```yaml
- term: force push
  aliases: [force pushing, force pushed]
  short: A push that replaces the remote history with yours, deleting commits other people pushed.
  url: /foundations/what-is-git/
  group: Working with code
```

- `short` is one sentence, 20 words or fewer. It is a definition, not a warning.
- `url` names the page that teaches the term. Omit it when no page does, and the
  term links to the glossary entry instead.
- `group` is the heading it appears under on the glossary page.
- `noauto: true` keeps the term in the glossary but stops it being linked in prose.
- List every form a writer will type in `aliases`, including the plural.

### What earns an entry

Assume the reader knows nothing. A term earns an entry when someone new to
programming would stop reading to look it up. That includes everyday words used in
a specific sense here, such as logic, permission, client-side and browser.

Leaving such a word out is the more common mistake. A reader who does not know what
a browser is cannot learn what a client is.

### Rules

- Write the definition for someone with no background. A definition that uses two
  more undefined terms has failed.
- Never rely on the tooltip to carry a fact. A page defines its own terms in the
  prose, exactly as it would with no tooltips at all.
- The definition in the glossary and the definition on the page agree. When they
  drift, the glossary is wrong.
- A term is never linked on the page that teaches it. That page is the definition.
- Only the first mention on a page is linked, so a page never fills with underlines.
- On the glossary page each definition is its own region. A definition that uses
  another term links to it, and never links to itself. Write definitions expecting
  this, so a reader who lands on one term can reach the terms it depends on.
- Set `noauto: true` when the word is also a common English verb, such as build,
  test, process or index. The linker cannot tell the two senses apart, and a wrong
  tooltip is worse than none.
- Never add an alias that is an ordinary word in another sense. `live` for
  production matched the sentence "both sides live in one repository".

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

## Scope: concepts, not keystrokes

An AI writes the commands. The reader does not need them. Teach the model, the
vocabulary and the decisions instead.

Do not write:

- Command lists, flag reference or click paths
- Step-by-step procedures the AI performs on request
- Installation instructions
- Anything the reader gets faster by asking their AI

Do write:

- What the thing is, and why it exists
- The mental model the reader needs to judge the AI's output
- The decision only a human makes
- The consequence the reader owns: what is irreversible, what leaks, what costs money
- The vocabulary needed to ask a precise question

Name a command only when the name is the concept. "A commit is one checkpoint" is
the concept. The full syntax is not.

**Test:** if the reader reaches the same result by asking their AI, cut it. If a
wrong answer costs them money, data or a security breach, keep it.

## Rules blocks

A rules block holds the non-negotiable statements for a page. It sits directly under
the definition, before the body. The reader who reads nothing else reads this.

Write it as a markdown list with the class applied by a kramdown attribute:

```markdown
{: .rules}
- **NEVER** commit a secret. Environment files, API keys, tokens, certificates.
- **ALWAYS** treat a committed secret as public and replace it.
```

The list renders as plain markdown in the GitHub repository view. The site styles it.

### The four words

| Word | Meaning | Exceptions |
|---|---|---|
| **NEVER** | The action causes irreversible harm | None |
| **ALWAYS** | Skipping the action causes harm eventually | None |
| **DON'T** | A common mistake with a better alternative | Yes, and you must know why |
| **DO** | The recommended default | Yes, and you must know why |

NEVER and ALWAYS remove judgment. DO and DON'T guide it. Choosing the wrong pair
teaches the reader to ignore both.

### Limits

- Maximum 5 rules in the block at the top of a page. Six rules teach none.
- Only NEVER and ALWAYS go at the top. DO and DON'T belong in the section they concern.
- One sentence per rule. Maximum 15 words. Imperative.
- Reserve NEVER for data loss, a security breach, money, or an irreversible action.
  Never use it for a style preference.
- Every NEVER names its consequence somewhere on the page.
- The body explains why. The rule does not repeat the explanation.

## Sentences that carry no information

A second sentence must add a fact. When it adds only rhythm, delete it.

### Say what a thing is

Define a thing by what it is. A definition that pivots to another subject has defined
nothing.

The ids page was summarised as "An id names one thing. It never proves you are allowed
to see it." The page is about ids. The second sentence is about permission, so a
reader learns what an id is not, from a topic they have not met yet.

- A definition names the thing, its purpose, and nothing else.
- Move the consequence into the body, where there is room to explain it.

### The contrast reflex

"X. Not Y." and "It is not A, it is B" are shapes, not information. They read as
insight because of the rhythm.

A negation earns its place only when it corrects a belief the reader actually holds,
and the page supplies the correct belief in the same breath. "Why a commit is not a
save" survives, because people do believe a commit is a save. "A name is not a key"
did not, because nobody believed it was, and the sentence existed for its cadence.

Test it by asking who holds the wrong belief. If the answer is nobody, the sentence is
an invented opponent. Delete it and state the fact.

### Other shapes to delete

- **Restatement for emphasis.** The second sentence repeats the first in stronger
  words. Keep one.
- **Verdict lines.** "This is the difference between a curiosity and a real defect."
  State the impact or say nothing.
- **Superlatives about a finding.** "The worst of the three" ranks for effect. Say
  what fails and for whom.
- **Graded asides.** "Probably worth checking first" either means check it first, or
  means nothing.

## Page shape

Every topic page uses this order:

1. **Title** — a question or a noun. Example: "What is Git".
2. **Definition** — 1 or 2 sentences. The first line on the page.
3. **Rules** — the non-negotiables. See Rules blocks below. Maximum 5.
4. **The problem** — the concrete failure this thing prevents.
5. **Mental model** — one picture the reader can hold.
6. **The parts** — named concepts, one short block each.
7. **What you decide** — the judgment the AI cannot make for you.
8. **Common mistakes** — real failures, not theory.
9. **Next** — 2 or 3 links.

Skip a section when it has nothing to say. Do not pad it.

## Sequence and prerequisites

Pages are read in order. A reader starting at the top must never meet an idea that a
later page explains.

Each page declares its place in front matter:

```yaml
tier: Foundations
slug: data-types
order: 2
requires: [variables-and-values]
```

- `requires` lists the pages a reader must have read. List only true prerequisites.
- The build fails when a page requires one that comes later, or one that does not exist.
- The site shows "Read first" at the top and "Next in this tier" at the bottom. Do not
  write either by hand.

Adding a page means asking one question: what must the reader already know? If the
answer is not yet a page, write that page first. The data types page needs variables
and values, because a reader who does not know what a value is cannot learn what kind
a value has.

## Per-language detail

A concept holds everywhere. How much a language helps varies enormously. Where that
variation changes what the reader must do, add an accordion below the main
explanation.

```markdown
<div class="languages" markdown="1">

<details markdown="1">
<summary>JavaScript and TypeScript</summary>

- **The point in bold.** Then the consequence.

</details>

</div>
```

- The languages and their order live in `_data/languages.yml`. Cover all of them.
  The build fails on a partial or reordered list, because a reader who uses the
  missing one learns that the page has nothing for them.
- The accordion is closed by default. The concept above it is the page. This is a
  footnote for whoever needs it.
- Write the difference, not a tutorial. C# has an exact decimal type for money and
  JavaScript has no whole number type at all. Those change what the reader does.
- Do not add an accordion where the languages agree. It teaches nothing and it rots.

## Jargon

Define a term the first time it appears, in the same sentence.

- Yes: "A commit is one saved checkpoint of your project."
- No: "Commit your work to the index before you push."

After the definition, use the term. Do not explain it again.

## Code

A code block shows a thing the reader must recognize, or a failure they must
understand. It is not a procedure to copy.

- Tag every code block with its language.
- Show what the reader will see on screen, not what they should type.
- Comments explain why, not what.
- Use real code, not pseudocode.

## Diagrams

Use a diagram when the idea has a shape: a sequence, a hierarchy, two things that
differ, or state that changes. Do not draw a list.

**Format.** Write diagrams as Mermaid inside a fenced `mermaid` block. Mermaid is
text, so it lives in version control and shows a readable diff. It renders on the
site and in the GitHub repository view. Use hand-written inline SVG only when
Mermaid cannot express the idea. Never use a screenshot or an image of text.

**Rules.**

- One idea per diagram. Split it when it needs more.
- Maximum 7 nodes. A larger diagram teaches nothing.
- Label every edge with a verb. An unlabelled arrow states no relationship.
- Follow the diagram with a one-line caption that names what to notice.
- Colour is never the only signal. The diagram must read in greyscale.
- The surrounding text carries the fact as well. A diagram supports the text and
  never replaces it.

## Claims

- State a fact or state nothing.
- Name the consequence when a thing is unsafe.
- Do not soften a warning to sound friendly.
- Give the version or the date for anything that changes.

### Never simplify into a falsehood

Plain language is required. Being wrong is not the price of it. A simplification that
makes the statement false is not a simplification, it is an error the reader cannot
detect.

A JavaScript number was described here as "a decimal". It is a binary floating point
number, and "decimal" names a different, exact type that other languages have. The
same page used "decimal" in that opposite sense one section later. A reader who
learned the wrong word had to unlearn it the first time they met the right one.

- Use the correct name, then explain it. That costs one clause.
- Never reuse a word that carries a different technical meaning elsewhere.
- Check a claim about a named type, format or standard. Do not write it from memory.
- Where accuracy and brevity conflict, keep accuracy and spend the extra sentence.

## Tone

Flat and direct. No jokes about how confusing the topic is. No apology for the
reader's level. Respect the reader by not wasting their time.

## Checklist before publish

- [ ] Every sentence is 25 words or fewer
- [ ] No semicolons
- [ ] Active voice throughout
- [ ] Every term defined on first use, in the prose and not only in the glossary
- [ ] No filler words from the list above
- [ ] One name per concept
- [ ] Code blocks tagged, and none of them is a procedure to copy
- [ ] No command list or step-by-step the AI would perform
- [ ] Every diagram has a caption and 7 nodes or fewer
- [ ] The rules block holds 5 rules or fewer, all NEVER or ALWAYS
- [ ] Every NEVER names its consequence in the body
- [ ] The page opens with the definition, not a preamble
