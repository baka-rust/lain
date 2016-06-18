grammar Lain;

// terminals
ID: [a-zA-Z_][a-zA-Z_0-9]* ;
INT: [0-9]+ ;
STRING: '"' ~["\\\r\n]+ '"' ;
BOOL: ('true' | 'false') ;
COMMENT: '//' ~( '\r' | '\n' )* -> skip ;
WS: ( '\t' | ' ' | '\r' | '\n' | '\u000C' )+ -> skip ;
NULL: 'null' ;

// non-terminals
program			: statement* EOF ;

statement		: if_statement
				| for_loop
				| expression ';'
				| 'return' expression ';'
				;

if_statement	: 'if' expression block ('else if' expression block)* ('else' block)? ;

for_loop		: 'for' (definition | ID) 'in' expression (expression ';' | block) ;

expression		: definition
				| assignment
				| definition_assignment
				| invocation
				| lambda
				| atom
				| ID
				| expression operand expression
				| unary_operand expression
				| '(' expression ')'
				| table_definition
				| meta_definition
				| table_access
				;

definition		: type ID ;

assignment		: ID ':=' expression 
				| table_access ':=' expression
				;

definition_assignment : type ID ':=' expression ;

invocation		: ID '(' expression_list? ')' ;

lambda			: '(' argument_list? ')' '->' ( '(' type_list ')' | type )? (block | ':' expression) ;

table_definition : '{' table_entry_list* '}' ;

table_entry_list : table_entry (',' table_entry)* ;

table_entry		: type ID ':' expression ;

expression_list	: expression (',' expression)* ;

argument_list	: definition (',' definition)* ;

meta_definition : '{' meta_entry_list* '}' ;

meta_entry_list	: (meta_entry | table_entry) (',' (meta_entry | table_entry))? ;

meta_entry		: type ID ;

table_access	: ID '[' STRING ']' ;

type_list		: type (',' type)* ;

block			: '{' statement* '}' ;

operand			: '*' | '/' | '+' | '-' ;

unary_operand	: '!' | '-' ;

type			: 'int' | 'uint' | 'float' | 'bool' | 'byte' | 'fn' 
				| 'string' | 'list' | 'table' | 'meta' | ID
				;

atom			: INT
				| STRING
				| BOOL
				| NULL
				;
