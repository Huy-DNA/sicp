# Problem

Louis Reasoner is having great difficulty doing Exercise 1.24. His `fast-prime?` test seems to run more slowly than his `prime?` test. Louis calls his friend Eva Lu Ator over to help. When they examine Louis’s code, they find that he has rewritten the expmod procedure to use an explicit multiplication, rather than calling square:

```scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
   ((even? exp)
     (remainder (* (expmod base (/ exp 2) m)
                   (expmod base (/ exp 2) m))
                m))
   (else
     (remainder (* base
                  (expmod base (- exp 1) m))
                m))))
```

“I don’t see what difference that could make,” says Louis. “I do.” says Eva. “By writing the procedure like that, you have transformed the `Θ(log n)` process into a `Θ(n)` process.” Explain.

# Answer

If we visualize the old process calls:

```scheme
(expmod 2 9 3)
(expmod 2 8 3)
(expmod 2 4 3)
(expmod 2 2 3)
(expmod 2 1 3)
(expmod 2 0 3)
```

It's a linear chain with `O(log n)` calls. This can be proven given the observation that after at least 2 calls, `exp` should at least halve in size.

If we visualize the new process calls:
```scheme
                                  (expmod 2 9 3)
                                  (expmod 2 8 3)
            (expmod 2 4 3)                                      (expmod 2 4 3)
(expmod 2 2 3)          (expmod 2 2 3)              (expmod 2 2 3)          (expmod 2 2 3)
```

It's a tree with a lot of duplicated calls. Observe that:

- The path from the route to a leaf is the same as the old linear chain, which has `O(log n)` calls. This also means that the tree is `O(log n)` in height.
- In 2 successive levels, there should be at least 1 level where a node is split into 2. This means that there should exist at least `height / 2` levels where a node is split into 2. Thus, there are at least `2^(height / 2)` nodes.

In conclusion, the steps taken are about `2^(f(n) / 2)` where `f(n) = O(log n)`. Using some math we can prove that this is `O(n)`.
