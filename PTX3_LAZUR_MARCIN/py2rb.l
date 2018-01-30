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
"range".*$ {cout << "dupa";}

%%

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