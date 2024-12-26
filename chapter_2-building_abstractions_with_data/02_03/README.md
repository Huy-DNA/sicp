# Problem

Implement a representation for rectangles in a plane. (Hint: You may want to make use of Exercise 2.2.) In terms of your constructors and selectors, create procedures that compute the perimeter and the area of a given rectangle. Now implement a different representation for rectangles. Can you design your system with suitable abstraction barriers, so that the same perimeter and area procedures will work using either representation?

# Answer

- Interface:

   ```
   (get-segment-xy rec)
   (get-segment-yz rec)
   (get-segment-zt rec)
   (get-angle-x rec)
   (get-angle-y rec)
   (get-angle-z rec)
   ```

- First representation: A triple of points.

- Second representation: A quadruple of angles and a point.
