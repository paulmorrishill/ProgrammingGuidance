---
layout: default
title: Glossary
summary: Every term this site treats as load-bearing, defined once, assuming you know nothing.
---

No term here is obvious. If a word on this site is unfamiliar, it is defined below,
and hovering it on any page shows the same definition.

{% assign groups = site.data.glossary | group_by: "group" %}

<nav class="toc">
{% for g in groups %}<a href="#group-{{ g.name | slugify }}">{{ g.name }}</a>{% endfor %}
</nav>

{% for g in groups %}
<h2 id="group-{{ g.name | slugify }}">{{ g.name }}</h2>

<dl class="glossary">
{% assign items = g.items | sort_natural: "term" %}
{% for entry in items %}
  <dt id="term-{{ entry.term | slugify }}">
    {% if entry.url %}<a href="{{ entry.url | relative_url }}">{{ entry.term }}</a>
    {% else %}{{ entry.term }}{% endif %}
  </dt>
  <dd>{{ entry.short }}</dd>
{% endfor %}
</dl>
{% endfor %}
