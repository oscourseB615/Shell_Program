%{
    #define _GNU_SOURCE
    #include <stdio.h>
	#include <string.h>
    #include <unistd.h>
	#include "global.h"

    // int yylex ();
    void yyerror ();
    
    int commandDone, i;
    char c;
%}

%token STRING
%token INPUT
%token OUTPUT
%token AND
%token EOL
%token OR

%%
line            :   /* empty */
                    |command EOL				    { execute(); commandDone = 1; return; }
;

command         :   fgCommand						{    }
                    |fgCommand AND                  {    }
;

fgCommand       :   simpleCmd						{    }
                    |fgCommand OR simpleCmd         {    }
;

simpleCmd       :   progInvocation inputRedirect outputRedirect
;

progInvocation  :   STRING args						{    }
;

inputRedirect   :   /* empty */						
                    |INPUT STRING                   {   }
;

outputRedirect  :   /* empty */						
                    |OUTPUT STRING                  {    }
;

args            :   /* empty */
                    |args STRING 					{    }
;

%%

/****************************************************************
                  错误信息执行函数
****************************************************************/

void yyerror()
{
    printf("bison : 你输入的命令不正确,请重新输入!\n");
}

/****************************************************************
                  main主函数
****************************************************************/
int main(int argc, char** argv) {

    init();
    commandDone = 0;

    printf("cyl@computer:%s$ ", get_current_dir_name()); //打印提示符信息

	while(1)
	{
        i = 0;
        c = getchar();
        if(c != -1)
            ungetc(c,stdin);
		yyparse();
        strcpy(lastBuff, inputBuff);

		if(commandDone == 1){
			commandDone = 0;
			addHistory(inputBuff);
		}

        inputBuff[0] = '\0';
        printf("cyl@computer:%s$ ", get_current_dir_name()); //打印提示符信息
	}
	return EXIT_SUCCESS;
}
