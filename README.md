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

### extended types
* `struct` - syntactic sugar around `tables`, resolves field access into key access
* `string` - a null-terminated array of `chars`, with syntactic sugar
* `package` - syntactic sugar around `structs` to make them usable as namespace'd packages

## s-lain
lain has an intermediate representation `s-lain`, centered around s-expressions, which represents a lain program's AST.
s-lain forms the fundamental basis for lain's overall design, and all of lain's syntax is centered around abstractions of s-lain.
Developing while using s-lain as a basis enables rapid syntax changes while keeping in line with lain's core philosophy.

### statements
s-lain has several basic statements. each statement always resolves to an atom, or "typed element".
```lisp
atom
( )
( block statements... ) // execute statements in order, return result of last
( invoke block args... ) // function invocation

( let id block ) // variable assignment
( lambda ( args.. ) block ) // function definition
( type block ) // returns the type of the block
( {operator} args... ) // invokes operator
( {atom} args... ) // returns atom of type t from args

( match ( condition ) block ( condition ) block ... ) // final condition should match true to act as an "else"

( len id ) // length of a structured atom
( get id arg ) // get value from a structured atom
( set id arg ) // set value in a structured atom
```

### operators
```
+ // sums all args
- // subtracts all args in succession
/ // divides all args in succession
* // product of all args

< // arg0 < arg1
> // arg0 > arg1
<=
>=
== // equivalent
!= // not equivalent
! // not arg0
|| // boolean or of args
&& // boolean and of args
| // bitwise or of args
& // bitwise and of args
```


### match statements
`match` statements form the fundamental basis for flow control in s-lain. In true lain, they will be abstracted to function in a similar aspect to haskell's (and other functional languages') pattern matching.
```lisp
( block
    ( let input 5 )
    ( let output
        ( match
            ( == ( type input ) int ) "input was an int"
            ( == ( type input ) uint ) "input was an unsigned int"
            true "input was not an int or an unsigned int"
        )
    )
)
```

This block will return the string `"input was an int"`.


## explicit lain and sugar
Explicit lain is the language after abstraction. Syntax is up in the air, but the general philosophy is that each segment of basic syntax relates back to a statement in s-lain, and that additional levels of abstraction will be layered on top.


### match example in explicit lain
Taking our same match example:
```javascript
	{
		input := 5;
		output := match(
			type input == int : "input was an int",
			type input == uint : "input was an unsigned int",
			true : "input was not an int or an unsigned int"
		);
	}
```

And with sugar (abstraction):
```javascript
	{
		input := 5
		output (input) =>
			<int> : "input was an int",
			<uint> : "input was an unsigned int",
			_ : "input was not an int or an unsigned int"
	}
```

And with a lambda:
```javascript
	check := (input) -> (input) =>
		<int> : "input was an int",
		<uint> : "input was an unsigned int",
		_ : "input was not an int or an unsigned int"
	check 5
```

Which can again be abstracted to:
```javascript
	check := (input) ==>  
		<int> : "input was an int",
		<uint> : "input was an unsigned int",
		_ : "input was not an int or an unsigned int"
	check 5
```
And now we have a function with haskell style matching, just by layering our abstractions out.
