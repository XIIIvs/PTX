%{
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <stack>

#define YY_DECL extern "C" int yylex()

void transform_range(char* text, int length);
void nesting(char* text, int length);

using namespace std;
stack <int> nest_stack;
int nest_frst = 0;


%}

PUNCT [-+*/=<>:]*
ID  [A-Za-z_][A-Za-z0-9_]*
INT [0-9]+

%option noyywrap

%%

"self, " {}
":" {}
"print" {cout << "puts";}
^" "* {nesting(yytext, yyleng);}
"range".*$ {transform_range(yytext, yyleng);}

%%

void transform_range(char* text, int length) {
    cout << "0..";
    for (int i = 6; i < length-2; i++) {
        cout << text[i];
    }
}

void nesting(char* text, int length) {
    int nest_level = length;

    if (nest_level > nest_stack.top()) {
        nest_stack.push(nest_level);
        if (!nest_frst) {
            nest_frst = nest_level;
        }
    }

    if (nest_level < nest_stack.top()) {
        while (nest_level < nest_stack.top()) {
            int spaces = nest_stack.top();
            nest_stack.pop();
            for (int i = 0; i < spaces; i++) {
                cout << " ";
            }
            cout << "end\n";
        }
        if (nest_stack.top() == 0) {
            cout << "end\n";
        }
    }
    cout << text;
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