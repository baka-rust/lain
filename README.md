# lain
the lain language

## about
`lain` is being developed with a few precepts in mind:
* lambda is law - all concepts resolve to `atoms` (fundamental types)
* side-effects are bad, functional programming is good (although shouldn't be enforced)
* all complex data-structures can be represented by less complex ones
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
* `list` - serially accessible memory 
* `table` - a string -> value store of arbitrary types 

### extended types
* `struct` - syntactic sugar around `tables`, resolves field access into key access
* `string` - a null-terminated array of `chars`, with syntactic sugar
* `package` - syntactic sugar around `structs` to make them usable as namespace'd packages



### limited interpreter in lain
```
	instructions := "++*-/"
	
	run := ( ins i:0 total:0 ) ->
		new_total := match ins[i] :
			"+" -> total + 1
			"-" -> total - 1
			"*"	-> total * 2
			"/"	-> total / 2
		result := run ins i+1 new_total
	
	run instructions
	
```

### syntactic sugar
```
	(...) -> ... // create a lambda statement
	-> ... // create a lambda with no args
	[...] // apply a get on a structure
	: // create a table with the following keys
```


### built-in statements
```
( ) // empty
( statements... ) // block (last statement is return)
( id args... ) // function invocation
( type args... ) // atom creation
( let type id block<type> ) // definition
( let id block<type> ) // assignment / implicitly typed definition
( if block<bool> block ) // conditional
( if block<bool> block else block ) // else conditional
( lambda id ( args... ) block ) // function definition
( get id arg ) // get element from atom structure (list, table)
( set id arg ) // set element in atom structure (list, table)
( len id ) // returns the lenght of an atom structure
( id ) // return value of id (explicit return), equivalent to just `id`, but visually fitting
( default type id block ) // special type of arg, allows a default to be set 
```

### extended statements in `common` package
```
( append id<list> ) // append to a list
( pop id<list> ) // remove and return last element in a list
( expand uint value ) // create a list of uint size with value inside
( range uint uint id ) // return range of list id starting at arg0 and ending at arg1
( match string map ) // matches string to lambda in map
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
|| // bitwise or of args
&& // bitwise and of args
```



