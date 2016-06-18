# lain
the lain language

## about
`lain` is being developed with a few precepts in mind:
* lambda is law - all concepts resolve to `atoms` (fundamental types)
* side-effects are bad, functional programming is good
* all complex data-structures can be represented by less complex ones
* grammar should be driven by design, not the other way around
* advanced syntax should come from abstraction and sugar, which should be implemented in the language itself
* package structure should be obvious, and enforce good design/paradigms -- use "first require concatenation"

## proposed design:

### fundamental types (atoms)
* `int` - signed 32 bit integer
* `uint` - unsigned 32 bit integer
* `float` - a floating point number
* `bool` - a logical boolean
* `char` - a byte (character)
* `fn` - a lambda (function)
* `list` - serially accessible memory
* `table` - a string -> value store of arbitrary types
* `meta` - a string -> value store, with values not-required, creates a named type by which to derive other tables

### extended types
* `string` - a null-terminated array of `chars`, with syntactic sugar

## current grammar
```javascript
// assignment
int var := 5;

// lambda/function defn
fn a_function := () -> string {
	return "I am a string that will be returned!";
};
a_function(); // returns "I am a string that will be returned!"
```

