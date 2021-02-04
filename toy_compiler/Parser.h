#include <string>
#include <vector>

using namespace std;

class Parser {
    public:
        Parser();
        void startParser(vector<Token> &tokens);
    private:
        bool match(vector<Token> &tokens, Token expectedToken);
        int transformTypeString(string tokenType);
};

/* GRAMMAR
S -> OPER REG REG | MOV INTEGER REG | MOV REG REG | EOF
*/

// Constructor de la clase
Parser::Parser(){} //¿? idk

// Funcion para comparar lo esperado en el token con cierto token en especifico
// regresa un bool, recibe el 
bool Parser::match(vector<Token> &tokens, Token expectedToken) {
  if (!tokens.empty() && tokens[0].getType() == expectedToken.getType()) {
    tokens.erase(tokens.begin()); //borrar primera posicion
    return true;
  } else {
    if (tokens.empty()) {
      cout << "ERROR: Expecting \'" <<  expectedToken.getType() << "\', found nothing." << endl;
    } else {
      cout << "ERROR: Expecting \'" << expectedToken.getType() << "\', found \'" << tokens[0].getTokenValue() << "\'" << endl;
    }
    exit(0);
  }
  return false;
}

int Parser::transformTypeString(string tokenType){
  if(tokenType == "INTEGER") return 1;
  if(tokenType == "REGISTER") return 2;
  if(tokenType == "ASSIGNMENT") return 3;
  if(tokenType == "OPERATION") return 4;
  if(tokenType == "EOF") return 5;
}

// Funcion para iniciar el parser, recibe el vector de tokens por referencia
void Parser::startParser(vector<Token> &tokens) {
  // Validamos que el vector contenga algo antes de continuar
  if (tokens.empty()) {
    cout << "SYNTACTIC ERROR: Expecting a token, found nothing." << endl;
    // deberia ir return aqui ¿? -ate raul 
  }
  if (tokens[0].getType() == "EOF") {
    match(tokens, Token(";",5));
    return;
  }
  // transformar el tipo de string(token) a numero y se hace swith con ese
  switch (transformTypeString(tokens[0].getType())) { 
      case 4: //operacion
          // cout << "OPERATION" << endl;
          match(tokens,  Token("",4)); //type OPERATION
          match(tokens,  Token("",2));  //TYPE REGISTER
          break;
      case 3: //asignacion
          // cout << "ASSIGNMENT" << endl; //el token que sigue es un registro o un numero
          match(tokens,  Token("MOV",3)); //type ASSIGNMENT
          if (tokens[0].getType() == "REGISTER") { 
              match(tokens,  Token("",2)); //type REGISTER
          } else if (tokens[0].getType() == "INTEGER") { 
              match(tokens, Token("",1)); //type INTEGER
          } else {
            cout << "ERROR: Unexpected \'" + tokens[0].getTokenValue() + "\'." << "System will halt." << endl;
            exit(0);
          }
          break;
      default:
          cout << "ERROR: Unexpected \'" + tokens[0].getTokenValue() + "\'." << "System will halt." << endl;
          exit(0);
          break;
  }
    match(tokens, Token("",2)); //type REGISTER, lo que sigue a fuerza debe ser un registro
    startParser(tokens); //recursivo
}