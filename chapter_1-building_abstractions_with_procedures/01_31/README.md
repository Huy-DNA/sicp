# Problem

a. The `sum` procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures. Write an analogous procedure called `product` that returns the product of the values of a function at points over a given range. Show how to define factorial in terms of product. Also use `product` to compute approximations to `π` using the formula:

$$\frac{π}{4} = \frac{2 \cdot 4 \cdot 4 \cdot 6 \cdot 6 \cdot 8 \cdots}{3 \cdot 3 \cdot 5 \cdot 5 \cdot 7 \cdot 7 \cdots}$$

b. If your `product` procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

# Answer

- Linear recursive version:

  ```scheme
  (define (product term a next b)
    (define (product-iter c)
      (if (> c b)
        1
        (* (term c)
           (product-iter (next c)))))
    (product-iter a))
  ```

- Linear iterative version:

  ```scheme
  (define (product term a next b)
    (define (product-iter c result)
      (if (> c b)
        result
        (product-iter (next c) (* result (term c)))))
    (product-iter a 1))
  ```

Use `product` to approximate `π`:

  ```scheme 
  (define (pi-product n)
    (define (inc x) (+ x 1))
    (define (even? x) (= (remainder x 2) 0))
    (define (numerator ith)
      (if (even? ith)
        (+ ith 2)
        (+ ith 3)))
    (define (denominator ith)
      (if (even? ith)
        (+ ith 3)
        (+ ith 2)))
    (define (term ith)
      (/ (* (numerator ith) 1.0)
         (* (denominator ith) 1.0)))
    (* 4.0
      (product term 0 inc n)))
  ```

# Related exercises

- [1.32](../01_32/README.md)
- [1.33](../01_33/README.md)
