// Progressive enhancement for every page: diagrams, then glossary terms.
// Authors write plain markdown. Nothing here is required for the page to read.

import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';

const config = JSON.parse(document.getElementById('site-config').textContent);
const BASEURL = config.baseurl || '';

/* ---------- diagrams ---------- */

// Rouge wraps fenced blocks differently depending on the highlighter path, so
// match the language class wherever it lands and replace the whole block.
function renderDiagrams() {
  document.querySelectorAll('.language-mermaid').forEach((el) => {
    const codeEl = el.matches('code') ? el : el.querySelector('code');
    const source = (codeEl || el).textContent;
    const block = el.closest('div.highlighter-rouge') || el.closest('pre') || el;
    const figure = document.createElement('div');
    figure.className = 'mermaid';
    figure.textContent = source;
    block.replaceWith(figure);
  });

  const dark = window.matchMedia('(prefers-color-scheme: dark)').matches;
  mermaid.initialize({
    startOnLoad: true,
    securityLevel: 'strict',
    theme: dark ? 'dark' : 'default',
    themeVariables: { fontFamily: 'system-ui, -apple-system, "Segoe UI", Roboto, sans-serif' },
  });
}

/* ---------- rules blocks ---------- */

// A rules list is authored as a plain markdown list so it stays readable in the
// GitHub repository view. Tag each item by its keyword so prohibition and
// requirement look different.
function styleRules() {
  document.querySelectorAll('ul.rules > li').forEach((li) => {
    const keyword = li.querySelector('strong');
    if (!keyword) return;
    const word = keyword.textContent.trim().toUpperCase().replace(/[^A-Z]/g, '');
    const stop = word === 'NEVER' || word === 'DONT';
    li.classList.add('rule', stop ? 'rule-stop' : 'rule-go');
  });
}

/* ---------- glossary terms ---------- */

const slug = (s) => s.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
const trimSlash = (s) => s.replace(/[/]+$/, '');

// Whole-word search done without a regular expression, so a term containing
// punctuation needs no escaping. Returns the index of the match, or -1.
const isWordChar = (c) => (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9');

function findWholeWord(text, name) {
  const hay = text.toLowerCase();
  const needle = name.toLowerCase();
  for (let i = hay.indexOf(needle); i !== -1; i = hay.indexOf(needle, i + 1)) {
    const before = i === 0 ? '' : hay[i - 1];
    const after = hay[i + needle.length] || '';
    if (!isWordChar(before) && !isWordChar(after)) return i;
  }
  return -1;
}

// Skip anything where a link would be wrong or ugly.
const SKIP = 'a, code, pre, h1, h2, h3, h4, .mermaid, .caption, dt, dd';

function linkGlossaryTerms() {
  const dataEl = document.getElementById('glossary-data');
  const main = document.querySelector('main');
  if (!dataEl || !main) return;

  const here = trimSlash(location.pathname);
  const entries = [];

  for (const e of JSON.parse(dataEl.textContent)) {
    const target = e.url
      ? BASEURL + e.url
      : BASEURL + '/glossary/#term-' + slug(e.term);
    // Never link a term to the page the reader is already reading.
    const onOwnPage = Boolean(e.url) && trimSlash(BASEURL + e.url) === here;
    if (onOwnPage) continue;
    for (const name of [e.term, ...(e.aliases || [])]) {
      entries.push({ name, short: e.short, href: target, key: e.term });
    }
  }

  // Longest name first, so "force push" wins over "push".
  entries.sort((a, b) => b.name.length - a.name.length);

  const linked = new Set();

  for (const entry of entries) {
    if (linked.has(entry.key)) continue;

    const walker = document.createTreeWalker(main, NodeFilter.SHOW_TEXT, {
      acceptNode(node) {
        if (findWholeWord(node.nodeValue, entry.name) === -1) return NodeFilter.FILTER_REJECT;
        if (node.parentElement.closest(SKIP)) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      },
    });

    const node = walker.nextNode();
    if (!node) continue;

    // Keep the author's own capitalisation in the visible text.
    const at = findWholeWord(node.nodeValue, entry.name);
    const rest = node.splitText(at);
    const matched = rest.nodeValue.slice(0, entry.name.length);
    rest.nodeValue = rest.nodeValue.slice(entry.name.length);

    const link = document.createElement('a');
    link.className = 'gterm';
    link.href = entry.href;
    link.dataset.def = entry.short;
    link.textContent = matched;
    rest.parentNode.insertBefore(link, rest);
    linked.add(entry.key);
  }
}

function enableTermTooltips() {
  const tip = document.getElementById('term-tip');
  if (!tip) return;

  const GAP = 8;

  const show = (link) => {
    tip.textContent = link.dataset.def;
    // Park it at the origin first, so the measurement below is not affected by
    // wherever the previous tooltip sat.
    tip.style.left = '0px';
    tip.style.top = '0px';
    tip.hidden = false;

    const anchor = link.getBoundingClientRect();
    const box = tip.getBoundingClientRect();

    // Centre on the term, then pull it inside the viewport. Clamping to the
    // right edge first and the left edge second keeps a tooltip wider than the
    // viewport visible instead of pushing it off the left side.
    const centred = anchor.left + anchor.width / 2 - box.width / 2;
    const left = Math.max(GAP, Math.min(centred, window.innerWidth - box.width - GAP));

    const fitsAbove = anchor.top > box.height + GAP + 4;
    const top = fitsAbove ? anchor.top - box.height - GAP : anchor.bottom + GAP;

    tip.style.left = left + 'px';
    tip.style.top = top + 'px';
  };

  const hide = () => { tip.hidden = true; };

  // Capture phase, because mouseenter and focus do not bubble.
  for (const type of ['mouseenter', 'focus']) {
    document.addEventListener(type, (e) => {
      const link = e.target.closest && e.target.closest('a.gterm');
      if (link) show(link);
    }, true);
  }
  for (const type of ['mouseleave', 'blur']) {
    document.addEventListener(type, (e) => {
      if (e.target.closest && e.target.closest('a.gterm')) hide();
    }, true);
  }

  window.addEventListener('scroll', hide, { passive: true });
  window.addEventListener('keydown', (e) => { if (e.key === 'Escape') hide(); });
}

renderDiagrams();
styleRules();
linkGlossaryTerms();
enableTermTooltips();
