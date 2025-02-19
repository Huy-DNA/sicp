# Problem

Suppose we have a Huffman tree for an alphabet of `n` symbols, and that the relative frequencies of the symbols are `1`, `2`, `4`, ... , `2^(n-1)`. Sketch the tree for `n = 5`; for `n = 10`. In such a tree (for general n) how many bits are required to encode the most frequent symbol? The least frequent symbol?

# Answer

The characteristic of this is that each merge will merge the two smallest number and yield another smallest number.

Example:
- `1 + 2 = 3 < 4`
- `3 + 4 = 7 < 8`
- etc.

So the tree will be very left-skewed, and at each level only span 1 level to the right:
```
                    x
                x      x
             x    x
           x   x
         x   x
       x   x
```

So the most frequent symbol takes `1` bit while the least frequent symbol takes `(n-1)` bits.
