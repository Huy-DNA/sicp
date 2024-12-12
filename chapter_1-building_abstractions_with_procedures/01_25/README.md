# Problem

Alyssa P. Hacker complains that we went to a lot of extra work in writing `expmod`. After all, she says, since we already know how to compute exponentials, we could have simply written

```scheme
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
```

Is she correct? Would this procedure serve as well for our fast prime tester? Explain.

# Answer

This procedure wouldn't work well.

- Exponentation grows really fast.
- Prime test which this procedure is used in uses very large primes.
- The math operations will become significantly slower (DrRacket seems to support infinite integers).
