# ProgrammingGuidance

Guidance for people who build software with AI help: the concepts, mental models and
decisions that remain theirs.

Published at <https://paulmorrishill.github.io/ProgrammingGuidance/>

## Writing

Read [STYLE.md](STYLE.md) before adding a page. Two rules matter most:

1. **Concepts, not keystrokes.** If the reader gets the same result by asking their
   AI, it does not belong here.
2. **Simplified Technical English.** Short active sentences, one idea each, no
   semicolons, no phrasal verbs.

## Build

Jekyll on GitHub Pages. Markdown in, HTML out, no local tooling needed. Diagrams are
Mermaid inside fenced `mermaid` blocks, rendered in the browser.

## Checks

```bash
bundle exec rake check
```

Two gates, both run in CI. A failure in either blocks the deploy.

- **Links.** Every internal link and anchor in the built site must resolve. External
  links are not checked, because a network failure is not a fault in this repository.
- **Content.** A glossary definition lives in `_data/glossary.yml` and nowhere else.
  Repeating one in a page fails the build. The check also enforces the 20-word limit
  on definitions, the ban on semicolons, and the shape of a rules block.

## Local preview

Ruby 3.4 and Bundler are required.

```bash
bundle install
bundle exec rake serve
```

The site then runs at <http://localhost:4000>. `_config.dev.yml` clears the path
prefix so links work without the `/ProgrammingGuidance` segment.

GitHub Pages builds through `.github/workflows/pages.yml` with the same Jekyll
version, so local output matches the published site.
