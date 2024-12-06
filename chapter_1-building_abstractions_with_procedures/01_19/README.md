# Problem

There is a clever algorithm for computing the Fibonacci numbers in a logarithmic number of steps. Recall the transformation of the state variables $a$ and $b$ in the `fib-iter` process of Section 1.2.2: $a <- a + b$ and $b <- a$. Call this transformation $T$, and observe that applying $T$ over and over again $n$ times, starting with 1 and 0, produces the pair $Fib(n + 1)$ and $Fib(n)$. In other words, the Fibonacci numbers are produced by applying $T^n$, the nth power of the transformation $T$, starting with the pair $(1, 0)$. Now consider $T$ to be the special case of $p = 0$ and $q = 1$ in a family of transformations $T_{pq}$, where $T_{pq}$ transforms the pair $(a, b)$ according to $a <- bq + aq + ap$ and $b <- bp + aq$. Show that if we apply such a transformation $T_{pq}$ twice, the effect is the same as using a single transformation $T_{p′q′}$ of the same form, and compute $p′$ and $q′$ in terms of $p$ and $q$. This gives us an explicit way to square these transformations, and thus we can compute $T^n$ using successive squaring, as in the `fast-expt` procedure. Put this all together to complete the following procedure, which runs in a logarithmic number of steps:

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))
  (define (fib-iter a b p q count)
   (cond ((= count 0) b)
         ((even? count)
          (fib-iter a
                    b
                    ⟨??⟩ ; compute p′
                    ⟨??⟩ ; compute q′
                    (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))
```

# Answer

We have: $T_{pq}((a, b)) = (bq + aq + ap, bp + aq)$.

Then: $T^2_{pq}((a, b)) = T_{pq}((bq + aq + ap, bp + aq)) = ((bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p, (bp + aq)p + (bq + aq + ap)q)$ = (b(2pq + q^2) + a(2pq + q^2) + a(p^2 + q^2), a(2pq + q^2) + b(p^2 + q^2)).

Therefore: $T^2_{pq} \equiv T_{(p^2 + q^2)(2pq + q^2)}$.

The nth fibonacci number is the second component of $T^{n-2}_{01}((0, 1))$. 

Assume that we have $(a, b, p', q', count)$ such that $T^count_{p'q'}((a, b)) = T^n_{pq}((0, 1))$. If $count = 0$ then $b$ is the result. Thus, we'll try to reduce $count$ to $0$.

- If $count$ is even, then: $a <- a$, $b <- b$, $p' <- p'^2 + q'^2$, $q' <- 2p'q' + q'^2$, $count <- count / 2$.

- Otherwise: $a <- bq' + aq' + ap'$, $b <- bp' + aq'$, $p' <- p'$, $q' <- q'$, $count <- count - 1$.

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))
  (define (fib-iter a b p q count)
   (cond ((= count 0) b)
         ((even? count)
          (fib-iter a
                    b
                    (+ (* p p) (* q q)) ; compute p′
                    (+ (* 2 p q) (* q q)) ; compute q′
                    (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))
```
