# Problem

Define the `below` operation for painters. `below` takes two painters as arguments. The resulting painter, given a frame, draws with the first painter in the bottom of the frame and with the second painter in the top. Define `below` in two different ways—first by writing a procedure that is analogous to the `beside` procedure given above, and again in terms of `beside` and suitable rotation operations (from Exercise 2.50).

# Answer

- First way:
```scheme
(define (below painter1 painter2)
  (let ((down-painter (transform-painter painter1
                                         (make-vect 0.0 0.0)
                                         (make-vect 1.0 0.0)
                                         (make-vect 0.0 0.5)))
        (up-painter (transform-painter painter2
                                       (make-vect 0.0 0.5)
                                       (make-vect 1.0 0.0)
                                       (make-vect 0.0 1.0))))
    (lambda (frame)
      (down-painter frame)
      (up-painter frame))))
```
- Second way:
```scheme
(define (below painter1 painter2)
  (rotate90 (beside (rotate270 painter1)
                    (rotate270 painter2))))
```
