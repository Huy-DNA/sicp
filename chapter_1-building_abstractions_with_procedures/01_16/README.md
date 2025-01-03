# Problem

Design a procedure that evolves an iterative exponentiation process that uses successive squaring and uses a logarithmic number of steps, as does `fast-expt`. (Hint: Using the observation that $(b^{\frac{n}{2}})^2 = (b^2)^{\frac{n}{2]}$, keep, along with the exponent `n` and the base `b`, an additional state variable `a`, and define the state transformation in such a way that the product $ab^n$ is unchanged from state to state. At the beginning of the process `a` is taken to be `1`, and the answer is given by the value of `a` at the end of the process. In general, the technique of defining an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.)

# Answer

See `main.rkt`.

Remark: Cool use of invariants! I learned about the use of invariants for loop reasoning during our program reasoning course. This one evokes the same vibe.
