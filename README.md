# WDPG

WordNet in PostgreSQL.

This is an (admittedly sloppy) set of scripts to download, parse and dump the
[WordNet][wordnet] data into PostgreSQL.

[wordnet]: https://wordnet.princeton.edu

## Usage

```
make DATABASE=wdpg
```

`DATABASE` can specify a local PostgreSQL database or a connection URL.

Ruby is required. An alternate Ruby path can be specified with the make
variable `RUBY`.

## Structure

WDPG creates the following types:

- `pos` (part of speech)
- `pointer_symbol`
- `syntactic_marker`

WDPG creates the following tables:

- `pos_labels`
- `pointer_symbol_labels`
- `syntactic_marker_labels`
- `lemmas`
- `lemma_synsets`
- `synsets`
- `words`
- `synset_synsets`
- `word_words`

## License

Copyright © 2015, Curtis McEnroe <curtis@cmcenroe.me>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
