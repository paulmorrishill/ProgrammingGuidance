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

## 1. Undefined jargon

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

## 2. Assumed knowledge and sequence

*Origin: "the types page needs a variables page first so that they even know what we
are talking about".*

Check the page's `requires` in its front matter, then read the page assuming the
reader has read only those pages and nothing later.

Flag:

- A concept the page uses but neither teaches nor requires.
- A prerequisite listed that the page never actually needs.
- A page that would be understandable earlier in the order than it sits.

If the missing prerequisite is not yet a page, say which page needs writing.

## 3. Mechanical content

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

## 4. Diagrams

*Origin: "we need diagrams and stuff".*

Flag:

- An idea with a shape — a sequence, a boundary, a hierarchy, two things that differ,
  state that changes — explained only in prose.
- A diagram that restates a list instead of showing a relationship.
- An unlabelled edge. Every arrow states a relationship in a verb.
- A diagram over 7 nodes.
- A diagram with no caption saying what to notice.
- A fact that exists only in the diagram and not in the surrounding text.

## 5. Rules block

*Origin: "key alert style rules at the top for key stuff like NEVER: commit secrets".*

The block sits directly under the definition. Flag:

- No rules block on a page that has non-negotiables.
- More than 5 rules, or a rule that is not NEVER or ALWAYS.
- A NEVER used for a style preference rather than data loss, a security breach, money
  or an irreversible action.
- A NEVER whose consequence is never stated in the body. Every prohibition earns its
  place by naming what goes wrong.
- A rule over 15 words, or one that is not imperative.

## 6. Simplified Technical English

*Origin: the style guide adopts ASD-STE100 in STE-flavored mode.*

Flag, quoting the sentence:

- Over 25 words in a description, or over 20 in an instruction.
- Passive voice where an actor exists.
- Phrasal verbs: spin up, reach out, dive into, kick off, end up, set up.
- Filler: just, simply, basically, actually, "it is important to note that".
- Marketing adjectives: seamless, powerful, robust, blazing-fast.
- A hedge promoted to a fact, or a fact softened into a hedge.
- Synonym rotation. One thing must keep one name across the page.

## 7. Per-language variation

*Origin: "on types we could be talking about so many different systems, we need an
accordion where there is large variation".*

Ask whether the concept behaves differently across JavaScript, Python, C#, Java and
PHP in a way that changes what the reader must do.

Flag:

- Large variation, no accordion.
- An accordion whose entries say the same thing in five ways. The languages agree, so
  the accordion is noise and should go.
- An entry that teaches the language rather than naming the difference.

## 8. Page shape

*Origin: the style guide fixes the order.*

Definition → rules → the problem → mental model → the parts → what you decide →
common mistakes → next.

Flag a page that opens with a preamble instead of the definition, a section padded
because the template listed it, or a missing "what you decide" on a page where real
judgment exists.

## 9. Honesty about the reader's job

*Origin: the site's premise. The AI writes the code, so the page must carry what the
AI cannot decide.*

Flag a page that explains a concept but never says what the reader must decide, or
which failures they own. This is the difference between this site and documentation.
