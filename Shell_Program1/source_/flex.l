%{
	#include "global.h"
	#include <string.h>
	#include <stdio.h>

	enum yytokentype{
		STRING	= 258,
		INPUT	= 259,
		OUTPUT	= 260,
		AND		= 261,
		EOL		= 262,
		OR		= 263
	};

%}

%%

"|"				{strcat(inputBuff, " "); strcat(inputBuff, yytext); return OR;}
"<"				{strcat(inputBuff, " "); strcat(inputBuff, yytext); return INPUT;}
">"				{strcat(inputBuff, " "); strcat(inputBuff, yytext); return OUTPUT;}
"&"				{strcat(inputBuff, " "); strcat(inputBuff, yytext); return AND;}
"*"				{strcat(inputBuff, "*");}
"?"				{strcat(inputBuff, "?");}
[ \t]+			{}
\n 				{return EOL;}
[^ \n\t]+		{strcat(inputBuff, " "); strcat(inputBuff, yytext); return STRING;}

%%