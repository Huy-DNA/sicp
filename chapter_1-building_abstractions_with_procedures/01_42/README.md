# Problem

Let `f` and `д` be two one-argument functions. The composition `f` and `д` is defined to be the function `x -> f(д(x))`. Define a procedure `compose` that implements composition. For example, if `inc` is a procedure that adds `1` to its argument,

```scheme
((compose square inc) 6)
49
```

# Answer

See `main.rkt`.
