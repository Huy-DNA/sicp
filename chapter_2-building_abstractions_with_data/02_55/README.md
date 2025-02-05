# Problem

Eva Lu Ator types to the interpreter the expression

```scheme
(car ''abracadabra)
```

To her surprise, the interpreter prints back quote. Explain.

# Answer

Probably, the interpreter has the following behaviors:
- *Syntactically* parse `'` as a call to quote: `''abracadabra` -> `(quote (quote abracadabra))`.
- Prints any symbols of the form `(quote <expr>)` as `'<expr>`.

Explanation:
- Evaluate: `(quote (quote abracadabra))` -> `'(quote abracadabra)` (A list with the `quote` and `abracadabra` symbols).
- Calling `car` on `'(quote abracadabra)` gives the `quote` symbol.
