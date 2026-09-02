---
layout: default
title: Data types
summary: Every value has a kind. The kind decides what happens next, and picking the wrong one corrupts data quietly.
---

A data type is the kind of a value. Text, a whole number, a decimal, true or false, a
date, a list. The kind decides what the computer does when you use the value.

Two values can look identical on screen and behave completely differently. This is
the source of a whole family of bugs that produce no error message at all.

{: .rules}
- **NEVER** store money as a decimal fraction. Store whole pence or cents.
- **NEVER** store a date without knowing its time zone. Store UTC.
- **NEVER** treat a phone number, postcode or reference as a number.
- **ALWAYS** convert text to a number before doing arithmetic with it.
- **ALWAYS** decide what an empty value means before you allow one.

## The problem

Nothing here raises an error. Each one gives a wrong answer and continues.

```text
"5" + 1          becomes "51"
0.1 + 0.2        becomes 0.30000000000000004
"07700 900123"   becomes 7700900123
Boolean("false") becomes true
```

The last one is worth reading twice. The text `false` is not the value false. Any text
that is not empty counts as true.

## Mental model

The same characters carry a different kind, and the kind decides the behaviour.

```mermaid
flowchart LR
    A["Text: 5"] -- "add 1" --> B["51, joined together"]
    C["Number: 5"] -- "add 1" --> D["6, added up"]
```

Everything arriving from outside your program is text. A web form sends text. A web
address holds text. A file holds text. Something must convert that text into the kind
you meant, and if you do not choose where, the language chooses for you.

## The kinds you meet

| Kind | Holds | Use it for | Never use it for |
|---|---|---|---|
| Text | Characters | Names, addresses, phone numbers, postcodes, ids | Arithmetic |
| Whole number | Counts with no fraction | Quantities, money in pence, positions | Anything needing a half |
| Decimal | Fractions, approximately | Measurements, averages, percentages | Money |
| True or false | One of two states | A setting that is on or off | Anything with a third state |
| Date and time | One instant | When something happened | A duration, or a birthday |
| List | Many values in order | Search results, line items | One value |
| Nothing | The absence of a value | Recording that you do not know | A zero, or an empty answer |

## Money

A decimal cannot hold most fractions exactly. It holds the nearest value it can, and
the error is small. Add a thousand of those errors and the total no longer matches the
sum of its parts. Your accounts disagree by a penny and nobody can find why.

Store money as a whole number of the smallest unit. £12.34 is stored as `1234`. Divide
by 100 only when you show it to a person.

This is not a preference. Currency and rounding rules are legal requirements in many
places, and a decimal fraction cannot satisfy them.

## Dates and time zones

A date with no time zone is not an instant. It is an instant in a place, and you were
not told the place.

Store every moment in UTC, which is one worldwide clock with no daylight saving.
Convert to the reader's local time when you show it. If you store local time, then
twice a year one hour happens twice or never, and your ordering breaks.

A birthday is different. It has no time and no time zone, because it is the same day
everywhere. Store it as a plain date, not as an instant.

## The several kinds of nothing

"No value" is not one thing, and the differences matter.

| Value | Means |
|---|---|
| Missing | Nobody was ever asked |
| Empty text | Someone was asked and typed nothing |
| Null | Known to have no value |
| Zero | A real measured amount, which happens to be none |
| False | A real answer, which happens to be no |

A customer with zero orders and a customer whose order count was never counted are
different customers. Storing both as `0` throws that difference away permanently.

Decide which of these your field allows, and refuse the rest.

## Text that looks like a number

A postcode, a phone number, a bank sort code and most ids are text that happens to
contain digits.

Store any of them as a number and the leading zero disappears. `07700` becomes `7700`.
The value is now wrong and nothing warned you. The test is simple. If adding one to it
is meaningless, it is text.

## What types checking does and does not do

A type checker such as TypeScript reads your code before it runs and complains when
the kinds do not match. This catches a large class of mistakes early.

It checks nothing while the program runs. Data arriving from a browser, a file or
another company's service is whatever actually arrived. A declaration that it should
be a number is a note to you, not a guard. Check the real value when it arrives.

## What you decide

| Decision | Why it is yours |
|---|---|
| Which kind each piece of information is | Only you know whether adding one is meaningful |
| What an empty value means for this field | The database cannot tell absent from zero |
| Where text becomes a number | Leave it unchosen and it happens somewhere surprising |
| Which unit a number is in | `1234` is meaningless until you say pence |

## Common mistakes

- **Doing arithmetic on values from a form.** They are text until you convert them.
- **Storing prices as decimals.** Use whole pence.
- **Storing local time.** Store UTC and convert when displaying.
- **Allowing null everywhere by default.** Every later line must then handle it.
- **Trusting a declared type for outside data.** The declaration checks your code, not the world.

## Next

- [Ids]({{ '/foundations/ids' | relative_url }}) — why an id is text, not a number
- [Client and server]({{ '/foundations/client-and-server' | relative_url }}) — why outside data is never what it claims
- Databases and tables
