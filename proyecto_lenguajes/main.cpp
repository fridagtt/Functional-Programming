// MOV 21 #A &
//MOV 1 2
//SUB 21 3

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

#include "Token.h"

using namespace std;

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

		do {       // un sólo token --> pedazo del string
            character = line[index];
            cout <<"CHAR: "<< character << endl;
            state = transitionMatrix[state][filter(character)];
            index++;
            if(state > 0){
                token+=character;  
            }
            cout<<"token: " <<token<<endl;
            //cout<<"index: " <<index<<endl;
            cout<<"state: " <<state<<endl;
        } while (index < line.length() && state < 100);
        
        token =  removeSpaces(token);
        switch (state) {
            case 0:
                cout<<"caso 0"<<endl;
                //return tokens;
                break;
            case 101: // CASO INTEGER
                cout<<"caso 101"<<endl;
                tokens.push_back(Token (token, 1));
                break;
            case ERROR:  
                cout<<"LEXICAL ERROR: the string \'" << token << "\' is not a valid element in the language."<< endl;
                cout << "The system will halt." << endl;
                // exit();
                break;
            case 102:   //REGISTER
                cout<<"caso 102"<<endl;
                if (token == "#A" || token == "#B" || token == "#C" || token == "#D") {
                    tokens.push_back(Token (token, 2));
                }else{
                    cout<<"LEXICAL ERROR: the string \'" << token << "\' is not a valid element in the language."<< endl;
                    cout << "The system will halt." << endl;
                    // exit();
                }
                break;
            case 103:       //OPERATION || ASSIGNMENT   
                cout<<"caso 103"<<endl;
				if (token == "SUM" || token == "SUB" || token == "MUL" || token == "DIV") {
                    tokens.push_back(Token (token, 4));
				}
				else if (token == "MOV") {
                    tokens.push_back(Token (token, 3));
				}
				else{
					cout<<"LEXICAL ERROR: the string \'" << token << "\' is not a valid element in the language."<< endl;
                    cout << "The system will halt." << endl;
				}
				break;
            case 104:   // END OF FILE
                cout<<"caso 104"<<endl; 
                tokens.push_back(Token (token, 5));
                break;
        } // end Switch
        

        token = "";
        state = 0;  // row de transition matrix
	}				// end while gigante

} //end final

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

	for (int i = 0; i < tokens.size(); i++) {
		cout << "Tokens: \t" << tokens[i].getType() << " <- " << tokens[i].getTokenValue() << endl;
	}

	return 0;
}
