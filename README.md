Little package to parse python source code using Racket. Relies on `libpython` and the canonical Python `tokenize` implementation via [`pyffi`](https://soegaard.github.io/pyffi/).

Example:
```
$ ./tokenize.rkt json "$(curl -s https://raw.githubusercontent.com/python/cpython/3.12/Lib/tokenize.py)" | jq | head -n20
[
  {
    "end": [
      0,
      0
    ],
    "line": "",
    "start": [
      0,
      0
    ],
    "string": "utf-8",
    "type": 63
  },
  {
    "end": [
      21,
      3
    ],
    "line": "\"\"\"Tokenization help for Python programs.\n\ntokenize(readline) is a generator that breaks a stream of bytes into\nPython tokens.  It decodes the bytes according to PEP-0263 for\ndetermining source file encoding.\n\nIt accepts a readline-like method which is called repeatedly to get the\nnext line of input (or b\"\" for EOF).  It generates 5-tuples with these\nmembers:\n\n    the token type (see token.py)\n    the token (a string)\n    the starting (row, column) indices of the token (a 2-tuple of ints)\n    the ending (row, column) indices of the token (a 2-tuple of ints)\n    the original line (string)\n\nIt is designed to match the working of the Python tokenizer exactly, except\nthat it produces COMMENT tokens for comments and gives type OP for all\noperators.  Additionally, all token lists start with an ENCODING token\nwhich tells you which encoding was used to decode the bytes stream.\n\"\"\"\n",
```

Also see https://github.com/jbclements/python-tokenizer, which is an implementation written in pure Racket. 
