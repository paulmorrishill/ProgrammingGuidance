---
layout: default
title: Glossary
summary: Every term the site treats as load-bearing, defined once.
---

Each term below is defined in one place and reused everywhere. Where a page teaches
the idea in full, the entry links to it.

<dl class="glossary">
{% assign terms = site.data.glossary | sort_natural: "term" %}
{% for entry in terms %}
  <dt id="term-{{ entry.term | slugify }}">
    {% if entry.url %}<a href="{{ entry.url | relative_url }}">{{ entry.term }}</a>
    {% else %}{{ entry.term }}{% endif %}
  </dt>
  <dd>{{ entry.short }}</dd>
{% endfor %}
</dl>
