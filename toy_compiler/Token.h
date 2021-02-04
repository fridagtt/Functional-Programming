#include <string>

using namespace std;

class Token {
    public:
        Token(string value, int numType);
        string getType();
        string getTokenValue() {return this->value;}
        
        string getValue() {return this->value;}
        enum Type { //constant range of values
            INTEGER,    // 1
            REGISTER,   // 2
            ASSIGNMENT, // 3
            OPERATION,  // 4
            OEF         // 5
        };
        // void setType(Type type);
    private:
        string value;
        Type type;
};

Token::Token(string value, int numType) {
    this->value = value;
    switch(numType){
        case 1:
            type = INTEGER;
        break;
        case 2:
            type = REGISTER;
        break;
        case 3:
            type = ASSIGNMENT;
        break;
        case 4:
            type = OPERATION;
        break;
        case 5:
            type = OEF;
        break;

    }
}
string Token::getType(){
     if(type == INTEGER) return "INTEGER";
     if(type == REGISTER) return "REGISTER";
     if(type == ASSIGNMENT) return "ASSIGNMENT";
     if(type == OPERATION) return "OPERATION";
     if(type == OEF) return "EOF";
}

