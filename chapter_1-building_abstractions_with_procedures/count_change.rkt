(define (count-change money)
  (define (count-change-iter remaining-money kinds-of-coins)
    (cond ((< remaining-money 0) 0)
          ((= remaining-money 0) 1)
          ((= kinds-of-coins 0) 0)
          (else (+ (count-change-iter remaining-money (- kinds-of-coins 1))
                   (count-change-iter (- remaining-money (coin-value kinds-of-coins)) kinds-of-coins)))))
  (define (coin-value kind)
    (cond ((= kind 1) 1)
          ((= kind 2) 5)
          ((= kind 3) 10)
          ((= kind 4) 25)
          ((= kind 5) 50)))
  (count-change-iter money 5))
