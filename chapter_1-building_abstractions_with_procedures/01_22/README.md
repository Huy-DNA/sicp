# Problem

Most Lisp implementations include a primitive called `runtime` that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds). The following `timed-prime-test` procedure, when called with an integer `n`, prints `n` and checks to see if `n` is prime. If `n` is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.

```scheme
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))
```

Using this procedure, write a procedure `search-for-primes` that checks the primality of consecutive odd integers in a specified range. Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than 100,000; larger than 1,000,000. Note the time needed to test each prime. Since the testing algorithm has order of growth of `Θ(sqrt(n))`, you should expect that testing for primes around 10,000 should take about `sqrt(10)` times as long as testing for primes around 1000. Do your timing data bear this out? How well do the data for 100,000 and 1,000,000 support the `Θ(sqrt(n))` prediction? Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

# Answer

```scheme
(define (even? i)
  (= (remainder i 2) 0))

(define (search-for-primes start end)
  (define (search-for-primes-iter i)
    (cond ((> i end) void)
          ((even? i) (search-for-primes-iter (+ i 1)))
          (else (timed-prime-test i)
                (search-for-primes-iter (+ i 2)))))
  (search-for-primes-iter start))
```

Full running code in `main.rkt` (DrRacket).

- Three smallest primes larger than 1000:

```
> (search-for-primes 1000 1019)

1001
1003
1005
1007
1009 *** 0.00146484375
1011
1013 *** 0.001708984375
1015
1017
1019 *** 0.001708984375
```

- Three smallest primes larger than 10000:

```
> (search-for-primes 10000 10037)

10001
10003
10005
10007 *** 0.00244140625
10009 *** 0.0029296875
10011
10013
10015
10017
10019
10021
10023
10025
10027
10029
10031
10033
10035
10037 *** 0.002685546875
```

- Three smallest primes larger than 100000:

```
> (search-for-primes 100000 100043)

100001
100003 *** 0.00634765625
100005
100007
100009
100011
100013
100015
100017
100019 *** 0.006103515625
100021
100023
100025
100027
100029
100031
100033
100035
100037
100039
100041
100043 *** 0.00634765625
```

- Three smallest primes larger than 1000000:

```
> (search-for-primes 1000000 1000037)

1000001
1000003 *** 0.007080078125
1000005
1000007
1000009
1000011
1000013
1000015
1000017
1000019
1000021
1000023
1000025
1000027
1000029
1000031
1000033 *** 0.006103515625
1000035
1000037 *** 0.00634765625
```

The time taken for integers around `1000` is about `0.0017`ms.

The time taken for integers around `10000` is about `0.0027`ms.

`sqrt(10)` is a little larger than `3`.

This means that the program doesn't really run in time proportional to the number of steps.
