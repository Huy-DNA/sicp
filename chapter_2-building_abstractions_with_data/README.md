# Building abstractions with data

- The ability to construct compound data objects enables us to deal with data at a higher conceptual level than that of the primitive data objects of the language.

- Example: Rational numbers & the operation `add-rat` which computes the sum of two rationals
  - We can represent a rational number by 2 integers: a numerator and a denominator.
  - The operation `add-rat` would be implemented as 2 operations: One producing the numerator of the sum and one producing the denominator of the sum.
  -> It would better if we could "glue together" a numerator and denominator to form a pair (*coumpound data object*).
  -> We can regard rational number as a single conceptual unit.

- The use of *compound data* increases the modularity of programs:
  - We can treat a rational number as a whole instead of parts.
  - The part of our program that deals with rational numbers do not have to care about how the rational numbers may be presented.

- *Data abstraction*: The general technique of isolating the parts of a program that deal with *how data objects are represented* from the parts of a program that deal with how *data objects are used* is a powerful design methodology.

- Some key ideas:
  - *Data abstraction* enables us to erect suitable *abstraction barriers* between different parts of a program.
  - Prodedures alone can be used to form compound data, without any special "data" operations whatsoever. -> Blur the distinction between data and procedures.
  - *Closure* (a mathematical property) - The glue we use for combining data objects should allow us to combine compound data objects as well.
  - *Conventional interfaces* - A compound data object that can serve as an interface that allows multiple program modules to be combined in mix-and-match ways.
  - The choice of data representation can have significant impact on the time and space requirements of processes that manipulate the data.
  - *Generic operations* - Operations that must handle many different types of data/representations of data.
  - *Data-directed programming* - Allow individual data representation to be designed in isolation and combined *additively* (without modification).
