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
				| while_loop
				| expression ';'
				| keyword expression ';'
				;

if_statement	: 'if' expression block ('else if' expression block)* ('else' block)? ;

for_loop		: 'for' (definition | name) 'in' expression (expression ';' | block) ;

while_loop		: 'while' expression (expression ';' | block) ;

expression		: definition
				| assignment
				| definition_assignment
				| invocation
				| lambda
				| atom
				| name
				| unary_operand expression
				| expression operand_mul_div_mod expression
				| expression operand_add_sub expression
				| expression operand_compare expression
				| expression operand_and expression
				| expression operand_or expression
				| expression trail_operand
				| '(' expression ')'
				| table_definition
				| table_access
				;

definition		: type name ;

assignment		: name ':=' expression
				| table_access ':=' expression
				;

definition_assignment : type name ':=' expression ;

invocation		: name '(' expression_list? ')' ;

lambda			: '(' argument_list? ')' '->' ( '(' type_list ')' | type )? (block | ':' expression) ;

table_definition : '{' table_entry_list* '}' ;

table_entry_list : table_entry (',' table_entry)* ;

table_entry		: type ID ':' expression ;

expression_list	: expression (',' expression)* ;

argument_list	: definition (',' definition)* ;

table_access	: name '[' STRING ']' ;

type_list		: type (',' type)* ;

block			: '{' statement* '}' ;

operand_mul_div_mod			: '*' | '/' | '%';

operand_add_sub						: '+' | '-';

operand_compare 					: '>' | '<' | '>=' | '<=' | '!=' | '==';

operand_and								: '&&';

operand_or								: '||';

unary_operand	: '&' | '!' | '-' ;

trail_operand	: '++' | '--' ;

type			: '*' type
				|  'int' | 'uint' | 'float' | 'bool' | 'byte' | 'fn'
				| 'string' | 'list' | 'table' | 'meta' | name
				;

keyword			: 'return'
				| 'include'
				;

name			: ID
				| name '.' name
				| name ':' name
				| name '->' name
				;

atom			: INT
				| STRING
				| BOOL
				| NULL
				;
