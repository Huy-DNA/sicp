# Problem
As a large system with generic operations evolves, new types of data objects or new operations may be needed. For each of the three strategies—generic operations with explicit dispatch, data-directed style, and message-passing-style—describe the changes that must be made to a system in order to add new types or new operations. Which organization would be most appropriate for a system in which new types must often be added? Which would be most appropriate for a system in which new operations must often be added?

# Answer

To add new types:
  - In generic operations with explicit dispatch: Each generic operation must be modified to account for the new type (well, if they want to).
  - In data-directed style: No change needed, all the changes should be placed in the new type package.
  - In message-passing-style: No change needed, all the changes are in the new intelligent object. All the operations should be accounted in the objects though.

To add new operations:
  - In generic operations with explicit dispatch: No change needed, the new operation should handle all the existing data types though.
  - In data-directed style: Depending on the way you manage packages, if you organize type packages & you want to support the operations in the old types too, then you still have to modify the old type packages. Otherwise, all the changes are contained in the new operation package.
  - In message-passing-style: All the intelligent objects should be modified to support the new operations (if they want to).

If new types are often added, then either the first or the second scheme should be used. If new operations must often be added, then either the second or the third scheme should be used.
