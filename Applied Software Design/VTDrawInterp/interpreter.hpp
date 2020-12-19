#ifndef INTERPRETER_HPP
#define INTERPRETER_HPP

// system includes
#include <string>
#include <istream>


// module includes
#include "expression.hpp"
#include "environment.hpp"
#include "tokenize.hpp"


// Interpreter has
// Environment, which starts at a default
// parse method, builds an internal AST
// eval method, updates Environment, returns last result
class Interpreter {
public:
	bool parse(std::istream & expression) noexcept; //Parses the text into the AST
	Expression eval(); //Evaluates the AST
	Expression popDrawing();
	std::string getErrorMessage();
	void clearErrorMessage();
private:
	/*Expression buildAST(TokenSequenceType &tokens, unsigned int start);*/
	std::pair<unsigned int, Expression> buildAST(TokenSequenceType &tokens, unsigned int start); //Builds the abstract tree for evaluation later
	Expression evaluate(Expression &e); //Recursive evalutaion function
	bool errorChecking(Expression &expression); //Does all the error checking for the building of the AST
	Environment env = Environment();
	Expression ast;
	std::string errorMessage = std::string();
	std::deque<Expression> drawings = std::deque<Expression>();
};


#endif
