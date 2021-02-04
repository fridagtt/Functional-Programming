/*Equipo:
    A01039975 Frida Gutierrez Mireles 
    A01154891 Raúl Castellanos Herrero
    A01176807 Gabriel Ortega Jacobo

    05/09/20
    Programming Languages
    7th September, 2020
    Professor: José Carlos Ortiz Bayliss
*/
#include <algorithm>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <ctype.h>

using namespace std;

#include "Token.h"
#include "Parser.h"


const int ERROR = 9999;
const  int transitionMatrix [4][6] = {
        {0, 1, 3, 2, 104, ERROR},
        {101, 1, ERROR, ERROR, ERROR, ERROR},
        {ERROR, ERROR, 102, ERROR, ERROR, ERROR},
        {103, ERROR, 3, ERROR, ERROR, ERROR}
    };

// funcion para quitar los espacios
string removeSpaces(string str){
    str.erase(std::remove_if(str.begin(), str.end(), ::isspace), str.end());
    return str;
}

int filter(char c){
    if(c == '\n' || c == '\r' || c == '\t' || c == '\f' || c == '\v' || c == ' ') return 0; //Cualquier tipo de espacio
    if(c > 47 && c < 58) return 1; //ASCII digits {0,1,...8,9}
    if(c > 64 && c < 87) return 2; //ASCII letters {A,B...,T,U,V} nada más hasta V (por DIV y MOV)
    if(c == '#') return 3; //Caso para caracter #
    if(c == ';') return 4; //Caso para caracter ;
	return 5; //Caracteres erroneos
}

void checkLine(string line, vector<Token> &tokens){
    char character;
    int state = 0, index = 0;
    string token = "";

	while (index < line.length()){ //WHILE --> revisa toda la línea

		do { // un sólo token --> pedazo del string
            character = line[index];
            state = transitionMatrix[state][filter(character)];
            index++;
            if(state > 0){
                token+=character;  
            }
            // cout<<"token: " <<token<<endl;
            // cout<<"index: " <<index<<endl;
            // cout<<"state: " <<state<<endl;
        } while (index < line.length() && state < 100);
        
        if (index == line.length() && state < 100){
            character = token[0];
            if (filter(character) == 1){
                state = 101;
            }
        }

        token =  removeSpaces(token);
        switch (state) {
            case 0:
                //return tokens;
                break;
            case 101: // CASO INTEGER
                tokens.push_back(Token (token, 1));
                break;
            case ERROR:  
                cout << "LEXICAL ERROR: the string \'" << token << "\' is not a valid element in the language. System will halt." << endl;
                exit(0);
                break;
            case 102:   //REGISTER
                if (token == "#A" || token == "#B" || token == "#C" || token == "#D") {
                    tokens.push_back(Token (token, 2));
                }else{
                    cout << "LEXICAL ERROR: the string \'" << token << "\' is not a valid element in the language. System will halt." << endl;
                    exit(0);
                }
                break;
            case 103:       //OPERATION || ASSIGNMENT   
				if (token == "SUM" || token == "SUB" || token == "MUL" || token == "DIV") {
                    tokens.push_back(Token (token, 4));
				}
				else if (token == "MOV") {
                    tokens.push_back(Token (token, 3));
				}
				else{
					cout << "LEXICAL ERROR: the string \'" << token << "\' is not a valid element in the language. System will halt." << endl;
                    exit(0);
				}
				break;
            case 104:   // END OF FILE
                tokens.push_back(Token (token, 5));
                break;
        } // end Switch
    
        token = ""; //clear token
        state = 0;  // restart state
	} // end while gigante

} //end function

int main(){

    //DECLARACION DE VARIABLES
    string file, line;
    char character;
    ifstream myFile("file.txt");

    vector<Token> tokens;
	
    while(!myFile.eof()) {
        getline(myFile,line);
        checkLine(line, tokens); 
    }

    //tokens ready

    //debug tokens
	for (int i = 0; i < tokens.size(); i++) {
		cout << "Tokens: \t" << tokens[i].getType() << " <- " << tokens[i].getTokenValue() << endl;
	}

    //parser of tokens
    Parser parse;
    parse.startParser(tokens);

    cout << "The input is a well formed expresssion. :)" << endl;
	return 0;
}
