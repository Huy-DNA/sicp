# Problem

Give combinations of `car`s and `cdr`s that will pick 7 from each of the following lists:

```scheme
(1 3 (5 7) 9)
((7))
(1 (2 (3 (4 (5 (6 7))))))
```

# Answer

```scheme
(1 3 (5 7) 9)
cdr -> cdr -> car -> cdr -> car
```

```scheme
((7))
car -> car
```

```scheme
(1 (2 (3 (4 (5 (6 7))))))
cdr -> car -> cdr -> car -> cdr -> car -> cdr -> car -> cdr -> car -> cdr -> car
```
