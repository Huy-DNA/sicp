# Problem

The width of an interval is half of the difference between its upper and lower bounds. The width is a measure of the uncertainty of the number specified by the interval. For some arithmetic operations the width of the result of combining two intervals is a function only of the widths of the argument intervals, whereas for others the width of the combination is not a function of the widths of the argument intervals. Show that the width of the sum (or difference) of two intervals is a function only of the widths of the intervals being added (or subtracted). Give examples to show that this is not true for multiplication or division.

# Answer

For an interval `i`, we write `w(i)` to denote its width.

The width of the sum of two intervals is indeed a function only of the widths of the intervals being added:

  - Suppose we have the interval `i1` with the upper-bound `u1` and the lower-bound `l1` and the interval `i2` with the upper-bound `u2` and the lower-bound `l2`.

  - The sum of `i1` and `i2` is an interval with the upper-bound `u1+u2` and the lower-bound `l2+l1`.

  - The width of the sum of the two intervals is `w(i1+i2) =  ((u1+u2) - (l1+l2)) / 2 = w(i1) + w(i2)`.

Similarly with the intervals being subtracted.

To show that this is not true for multiplication or division means that we have to show that the `w(i1*i2)` is not a function of `w(i1)` and `w(i2)`. We just have to show 2 cases where `w(i1)` and `w(i2)` are the same but result in different `w(i1*i2)`.
