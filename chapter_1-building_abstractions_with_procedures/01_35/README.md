# Problem

Show that the golden ratio ϕ (Section 1.2.2) is a fixed point of the transformation `x -> 1 + 1/x`, and use this fact to compute ϕ by means of the `fixed-point` procedure.

# Answer

By definition, the two quantities `a` and `b`, where `a > b > 0` are in a **golden ratio** if $\frac{a + b}{a} = \frac{a}{b}$. In this case $ϕ = \frac{a}{b} > 1$. Thus, $\frac{a + b}{a} = 1 + \frac{b}{a} = 1 + \frac{1}{ϕ}$ (we're sure that `ϕ` cannot be `0` by the way).

If we consider $f(x) = 1 + \frac{1}{x}$ then ϕ must be fixed-point of `f` by definition.

We can use this finding to compute `ϕ` as follows:

```scheme
(fixed-point (lambda (x) (+ 1 (/ 1 x))))
             1)  ; we know that ϕ is somewhere > 1
```

Result:

```
> (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1)
233/144
```

`233/144` is close to `1.618`.
