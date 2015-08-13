grammar Lain;

// terminals
ID: [a-zA-Z_][a-zA-Z_0-9]* ;
INT: [0-9]+ ;
STRING: '"' ~["\\\r\n]+ '"' ;
BOOL: ('true' | 'false') ;
COMMENT:  '//' ~( '\r' | '\n' )* -> skip ;
WS: ( '\t' | ' ' | '\r' | '\n'| '\u000C' )+ -> skip ;

// non-terminals
program		:	statements EOF
			;

statements	:	fstatement statements
			|
			;

// decides if a statement needs a semicolon
fstatement	:	statement ';'
			|	block
			|	match
			|	assignment ';'	// here and not in statement, as it can only be on the far left
			;

block		:	'{' statements '}'
			;

assignment	:	ID ':=' statement
			;

statement	:	atom
			|	ID
			|	statement '(' fargs ')' // invocation, not own non-terminal because explicit left-recursion is required
			|	lambda
			;

// function (invocation) arguments
fargs		:	statement (',' statement)*
			|
			;

lambda		:	'(' largs ')' '->' fstatement
			;

// lambda (function defn) arguments
largs		:	ID (',' ID)*
			|
			;

// match statement
match		:	'=>' '{' match_rule (',' match_rule)+ '}'
			;

match_rule	:	statement ':' statement
			;

atom		:	INT
			|	STRING
			|	BOOL
			;