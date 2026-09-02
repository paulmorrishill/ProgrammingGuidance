---
name: content-review
description: Review Programming Guidance pages for undefined jargon, assumed knowledge, mechanical filler, missing diagrams, weak rules blocks and Simplified Technical English. Use before publishing a page, after drafting one, when asked to check or review site content, or when asked whether a page assumes too much. Asks which pages to review, then fans out one subagent per page.
---

# Content review

Reviews pages against the rubric in `references/rubric.md`. Every check there exists
because a real page failed it, and the origin of each is recorded.

The point of this review is the reader who knows nothing. A page that reads well to
somebody who already programs can still be useless to them.

## Step 1. Run the automated gates first

```bash
bundle exec rake check
```

These cover broken links, duplicated glossary definitions, definition length,
semicolons, rules-block shape, sequence integrity and language-list completeness.

If they fail, report that and stop. There is no point reviewing prose while the
mechanical gates are red. Fix those first, then start again.

## Step 2. Ask which pages to review

Always ask. Do not assume the scope.

Use AskUserQuestion with these options:

- **Changed pages** — pages touched since the last commit, or on this branch. Get them
  with `git status --porcelain` and `git diff --name-only master...HEAD`. Recommend
  this one when the working tree is dirty.
- **One tier** — every page sharing a `tier` in its front matter.
- **A single page** — ask which.
- **Everything** — every markdown page with a `slug` in its front matter.

Resolve the answer to a concrete file list and show it before continuing. If the list
is empty, say so and stop.

## Step 3. Fan out, one subagent per page

Spawn the subagents in a single message so they run at once. Use the
`general-purpose` agent type.

Give each subagent this prompt, with `<PAGE>` replaced:

> Review one page of the Programming Guidance site. Report problems. Change nothing.
>
> Read these first, in this order:
> 1. `.claude/skills/content-review/references/rubric.md` — the checks and their severities
> 2. `STYLE.md` — the writing rules the site commits to
> 3. `_data/glossary.yml` — every term the site has already defined
> 4. `<PAGE>` — the page under review
>
> Also read every page listed in the page's `requires` front matter, because the
> reader has read those and nothing later.
>
> Work through all eleven rubric sections in order. For each finding report:
> - the rubric section number and name
> - severity: blocker, major or minor
> - the exact quoted text, with its line number
> - why it fails, in one sentence
> - a concrete replacement, not a description of one
>
> Section 1 is factual accuracy and it matters most. Verify every technical claim
> rather than assuming it, especially inside the per-language accordions. A confident
> wrong claim is worse than a missing one, because the reader has no reason to doubt
> it. Report a false claim as a blocker.
>
> For section 2, list every undefined term separately, and say for each whether it
> belongs in the glossary or in the page's prose.
>
> Be specific and be hard to please. A review that finds nothing on a first draft is
> a review that was not done. If a section genuinely passes, say so in one line and
> move on.
>
> Return your findings as markdown, ordered by severity, most severe first. No
> preamble and no summary of the page.

## Step 4. Synthesise

Read every subagent's findings. Then:

- Drop anything the automated gates already cover.
- Merge findings that repeat across pages into one entry naming every page. A term
  missing from the glossary usually appears on several.
- Sort by severity, then by how many pages each affects.
- Resolve disagreements yourself by reading the page. Subagents are sometimes wrong,
  and a confident finding is not a correct one.

## Step 5. Report

Give the user, in the terminal:

1. One line on scope: how many pages, at which severities.
2. Blockers, each with page, quote and the fix.
3. Majors, grouped by rubric section.
4. Minors as a short list, not in full.
5. Any new glossary terms the review implies, as a ready-to-paste YAML block.

Then ask whether to apply the fixes. Do not edit during the review. The user decides
which findings are real, and a review that silently rewrites pages cannot be checked.

## After applying fixes

Run `bundle exec rake check` again. The duplication gate in particular catches a
common repair: pasting a glossary definition into the page it was missing from.
