# Review rubric

Every check below exists because a real page failed it. The origin is recorded so
nobody deletes a check without knowing what it caught.

The automated gates in `rake check` already cover broken links, duplicated glossary
definitions, definition length, semicolons, rules-block shape, sequence integrity and
language-list completeness. **Do not spend effort re-checking those.** This rubric
covers only what a script cannot judge.

Severity:

- **blocker** — the page teaches a beginner something false, or leaves them stuck.
- **major** — the page breaks a rule the style guide states outright.
- **minor** — the page is weaker than it should be, but still correct and usable.

---

## 1. Factual accuracy

*Origin: the JavaScript entry called a number "a decimal". It is a binary floating
point number. "Decimal" names a different, exact type that some other languages have,
and the C# entry on the same page used the word in that opposite sense.*

**A simplification that makes the statement false is not a simplification.** Plain
language is required. Being wrong is not the price of it.

Check every technical claim on the page:

- Is it true as written, not merely true in spirit?
- Does a named type, format or standard actually behave that way?
- Does a word carry a different technical meaning elsewhere on the site, or in a
  language the reader may use? Flag anything that would mislead a reader who later
  meets the other meaning.
- Are version-dependent claims still true, and dated where they change?
- Do numbers, limits and examples hold up? Check them, do not assume.

Pay particular attention to the per-language accordions. They make specific claims
about specific systems, and a wrong one is worse than an absent one, because the
reader has no reason to doubt it.

When accuracy and simplicity genuinely conflict, keep accuracy and spend an extra
sentence. Naming a thing correctly and then explaining it costs one clause. Naming it
wrongly costs the reader every time they meet the real meaning.

## 2. Undefined jargon

*Origin: the reader hit `id` with no explanation, then `values`, `form`, `decimals`,
`UTC` and `displaying`.*

Read the page as somebody who has never programmed. Every word carrying technical
weight must be one of:

- an entry in `_data/glossary.yml`, or
- defined in the page's own prose at its first use.

Flag every term that is neither. Include ordinary English words used in a specific
sense: logic, permission, field, display, value, build, run.

A definition that leans on two more undefined terms has failed. Flag that too.

**Do not accept "it is obvious".** The audience floor is zero knowledge.

## 3. Assumed knowledge and sequence

*Origin: "the types page needs a variables page first so that they even know what we
are talking about".*

Check the page's `requires` in its front matter, then read the page assuming the
reader has read only those pages and nothing later.

Flag:

- A concept the page uses but neither teaches nor requires.
- A prerequisite listed that the page never actually needs.
- A page that would be understandable earlier in the order than it sits.

If the missing prerequisite is not yet a page, say which page needs writing.

## 4. Mechanical content

*Origin: "we don't need mechanical steps that AI can do, e.g. do not put the raw git
commands in there as the AI will know how to do those".*

Flag any of:

- Command lists, flags, or terminal invocations.
- Click paths through a user interface.
- Installation or setup steps.
- Numbered procedures the reader would get faster by asking their AI.

The test from the style guide: if the reader reaches the same result by asking their
AI, cut it. Keep it only when a wrong answer costs money, data or a security breach.

Naming a command because the name *is* the concept is allowed. "A commit is one
checkpoint" stays. The syntax does not.

## 5. Diagrams

*Origin: "we need diagrams and stuff".*

Flag:

- An idea with a shape — a sequence, a boundary, a hierarchy, two things that differ,
  state that changes — explained only in prose.
- A diagram that restates a list instead of showing a relationship.
- An unlabelled edge. Every arrow states a relationship in a verb.
- A diagram over 7 nodes.
- A diagram with no caption saying what to notice.
- A fact that exists only in the diagram and not in the surrounding text.

## 6. Rules block

*Origin: "key alert style rules at the top for key stuff like NEVER: commit secrets".*

The block sits directly under the definition. Flag:

- No rules block on a page that has non-negotiables.
- More than 5 rules, or a rule that is not NEVER or ALWAYS.
- A NEVER used for a style preference rather than data loss, a security breach, money
  or an irreversible action.
- A NEVER whose consequence is never stated in the body. Every prohibition earns its
  place by naming what goes wrong.
- A rule over 15 words, or one that is not imperative.

## 7. Simplified Technical English

*Origin: the style guide adopts ASD-STE100 in STE-flavored mode.*

Flag, quoting the sentence:

- Over 25 words in a description, or over 20 in an instruction.
- Passive voice where an actor exists.
- Phrasal verbs: spin up, reach out, dive into, kick off, end up, set up.
- Filler: just, simply, basically, actually, "it is important to note that".
- Marketing adjectives: seamless, powerful, robust, blazing-fast.
- A hedge promoted to a fact, or a fact softened into a hedge.
- Synonym rotation. One thing must keep one name across the page.

## 8. Sentences that carry no information

*Origin: the ids page was summarised as "An id names one thing. It never proves you
are allowed to see it." The page is about ids, and the second sentence is about
permission.*

Flag:

- A definition or summary that pivots to a different subject instead of saying what
  the thing is.
- The contrast reflex: "X. Not Y." or "It is not A, it is B", used for rhythm. A
  negation earns its place only when it corrects a belief a reader actually holds, and
  the page then supplies the correct belief. Ask who holds the wrong belief. If the
  answer is nobody, the sentence invented an opponent.
- Restatement for emphasis, where the second sentence repeats the first in stronger
  words.
- Verdict lines, superlatives about a finding, and graded asides such as "probably
  worth checking first".

For each, quote the sentence and give the replacement, or say to delete it.

## 9. Per-language variation

*Origin: "on types we could be talking about so many different systems, we need an
accordion where there is large variation".*

Ask whether the concept behaves differently across JavaScript, Python, C#, Java and
PHP in a way that changes what the reader must do.

Flag:

- Large variation, no accordion.
- An accordion whose entries say the same thing in five ways. The languages agree, so
  the accordion is noise and should go.
- An entry that teaches the language rather than naming the difference.

## 10. Page shape

*Origin: the style guide fixes the order.*

Definition → rules → the problem → mental model → the parts → what you decide →
common mistakes → next.

Flag a page that opens with a preamble instead of the definition, a section padded
because the template listed it, or a missing "what you decide" on a page where real
judgment exists.

## 11. Honesty about the reader's job

*Origin: the site's premise. The AI writes the code, so the page must carry what the
AI cannot decide.*

Flag a page that explains a concept but never says what the reader must decide, or
which failures they own. This is the difference between this site and documentation.
