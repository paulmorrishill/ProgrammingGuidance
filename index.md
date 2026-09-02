---
layout: default
title: Programming Guidance
summary: What you still need to know when an AI writes the code.
---

An AI writes the commands, the config and most of the code. It does not give you the
model underneath them. This site covers what is left: the ideas you need to judge the
output, and the decisions that stay yours.

Some pages depend on others. Each one names what to read first, and the list below
shows those dependencies. Nothing depends on a page further down, so reading in order
always works.

{% assign sequence = site.pages | where_exp: "p", "p.slug" %}

## Foundations

The ideas under the tools you already use.

{% assign foundations = sequence | where: "tier", "Foundations" | sort: "order" %}
<ol class="path">
{% for p in foundations %}
  <li>
    <span class="step">{{ p.order }}.</span>
    <a href="{{ p.url | relative_url }}">{{ p.title }}</a>
    {% if p.requires and p.requires.size > 0 %}
      <br><span class="step"></span><span class="needs">needs
      {% for req in p.requires %}
        {% assign before = sequence | where: "slug", req | first %}
        {{ before.title }}{% unless forloop.last %}, {% endunless %}
      {% endfor %}
      </span>
    {% endif %}
  </li>
{% endfor %}
</ol>

## Building

Data, state, async, APIs and the shapes a working app takes.

Coming soon.

## Shipping

Secrets, authorization, money, cost limits, operations and the law.

Coming soon.

---

Every load-bearing term is defined once in the [glossary]({{ '/glossary' | relative_url }}).
Hover any dotted term on a page to see its definition.

Pages follow the [writing style guide](https://github.com/paulmorrishill/ProgrammingGuidance/blob/master/STYLE.md).
