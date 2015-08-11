# lain
the lain language

## about
`lain` is being developed with a few precepts in mind:
* lambda is law - all concepts resolve to `atoms` (fundamental types)
* side-effects are bad, functional programming is good (although shouldn't be enforced)
* all complex data-structures can be represented by less complex ones
* explicit types provide safety and prevent headaches
* grammar should be driven by design, not the other way around
* package structure should be obvious, and enforce good design/paradigms -- use "first require concatenation"

## proposed design:

### fundamental types (atoms)
* `int` - signed 32 bit integer
* `uint` - unsigned 32 bit integer
* `float` - a floating point number
* `bool` - a logical boolean
* `char` - a byte (character)
* `fn` - a lambda (function)
* `array` - chunk of serially accessible memory 
* `table` - a string -> value store of arbitrary types 

### extended types
* `struct` - syntactic sugar around `tables`, resolves field access into key access
* `string` - a null-terminated array of `chars`, with syntactic sugar
* `package` - syntactic sugar around `structs` to make them usable as namespace'd packages