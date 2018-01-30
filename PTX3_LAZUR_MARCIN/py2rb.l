%{
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <stack>

#define YY_DECL extern "C" int yylex()
#define MAX_DEPTH 72

int nesting = 0 ;

using namespace std;
stack <int> nest_stack;

void transform_range(char* text, int length);

%}

PUNCT [-+*/=<>:]*
ID  [A-Za-z_][A-Za-z0-9_]*
INT [0-9]+

%option noyywrap

%%

"self, " {}
":" {}
"print" {cout << "puts";}
^" "* {ECHO;}
"range".*$ {transform_range(yytext, yyleng);}

%%

void transform_range(char* text, int length) {
    cout << "0..";
    for (int i = 6; i < length-2; i++) {
        cout << text[i];
    }
}

int main(int argc, char* argv[]) {
    FILE *kod = fopen("code.py", "r");
    if (!kod){
        cout << "Nie mozna otworzyc" << endl;
        return -1;
    }

    nest_stack.push(0);
    yyin = kod;
    yylex();
    cout << "\n" ;
}