#include "interpreter.hpp"

// system includes
#include <stack>
#include <stdexcept>
#include <iostream>
#include <map>

// module includes
#include "interpreter_semantic_error.hpp"

/*Recursive function used to form the AST*/
std::pair<unsigned int, Expression> Interpreter::buildAST(TokenSequenceType &tokens, unsigned int start) {
	Expression expression = Expression();
	Expression subExpression = Expression();
	for (unsigned int i = start; i < tokens.size(); i++) {
		if (tokens.at(i) == "(") {
			std::pair<unsigned int, Expression> expr = buildAST(tokens, i + 1);
			i = expr.first;
			subExpression = expr.second;
			if (expression.head.type == NoneType && subExpression.head.type != NoneType) {
				expression = subExpression;
				subExpression = Expression();
			}
			else if(subExpression.head.type != NoneType) {
				expression.tail.push_back(subExpression);
				subExpression = Expression();
			}
			continue;
		}
		else if (tokens.at(i) == "(") {
			throw(InterpreterSemanticError("Error : Invalid number of arguments"));
		}
		if (expression.head.type == NoneType && subExpression.head.type == NoneType && tokens.at(i) != "(" && tokens.at(i) != ")") {
			if (!token_to_atom(tokens.at(i), expression.head)) {
				throw(InterpreterSemanticError(expression.head.value.sym_value, true));
			}
		}
		else  if (tokens.at(i) != "(" && tokens.at(i) != ")") {
			if (!token_to_atom(tokens.at(i), subExpression.head)) {
				throw(InterpreterSemanticError(subExpression.head.value.sym_value, true));
			}
			expression.tail.push_back(subExpression);
			subExpression = Expression();
		}
		if (tokens.at(i) == ")" || i == tokens.size() - 1) {
			//Begin Error Checking
			if (errorChecking(expression)) {
				std::pair<unsigned int, Expression> expr(i, expression.tail.at(1));
				return expr;
			}
			//Error checking END
			std::pair<unsigned int, Expression> expr(i, expression);
			return expr;
		}
	}
	//Begin Error Checking
	if (errorChecking(expression)) {
		std::pair<unsigned int, Expression> expr(0, expression.tail.at(1));
		return expr;
	}
	//Error checking END
	std::pair<unsigned int, Expression> expr(0, expression);
	return expr;
}


//Recursive expression evaluator
Expression Interpreter::evaluate(Expression &e) {
	Expression expression = e;
	double num = 0;
	bool boolResult;
	for (unsigned int i = 0; i < e.tail.size(); i++) {
		if (!e.tail.at(i).tail.empty()) {
			expression.tail.at(i) = evaluate(e.tail.at(i));
		}
	}

	if (expression.head.value.sym_value == "point") {
		return Expression(std::make_tuple(expression.tail.at(0).head.value.num_value, expression.tail.at(1).head.value.num_value));
	}
	if (expression.head.value.sym_value == "line") {
		return Expression(std::make_tuple(expression.tail.at(0).head.value.point_value.first, expression.tail.at(0).head.value.point_value.second),
			std::make_tuple(expression.tail.at(1).head.value.point_value.first, expression.tail.at(1).head.value.point_value.second));
	}
	//if (expression.head.value.sym_value == "arc") {
	//	return Expression(std::make_tuple(expression.head.value.point_value.first, expression.head.value.point_value.second),
	//		std::make_tuple(expression.tail.at(0).head.value.point_value.first, expression.tail.at(0).head.value.point_value.second),
	//		expression.tail.at(1).head.value.num_value);
	//}
	if (expression.head.value.sym_value == "arc") {
		return Expression(std::make_tuple(expression.tail.at(0).head.value.point_value.first, expression.tail.at(0).head.value.point_value.second),
			std::make_tuple(expression.tail.at(1).head.value.point_value.first, expression.tail.at(1).head.value.point_value.second),
			expression.tail.at(2).head.value.num_value);
	}
	if (expression.head.value.sym_value == "sin") {
		return Expression(sin(expression.tail.at(0).head.value.num_value));
	}
	if (expression.head.value.sym_value == "cos") {
		return Expression(cos(expression.tail.at(0).head.value.num_value));
	}
	if (expression.head.value.sym_value == "arctan") {
		return Expression(atan2(expression.tail.at(0).head.value.num_value, expression.tail.at(1).head.value.num_value));
	}
	if (expression.head.value.sym_value == "if") {
		if (expression.tail.at(0).head.value.bool_value) {
			return expression.tail.at(1);
		}
		return expression.tail.at(2);
	}
	if (expression.head.value.sym_value == "<") {
		if (expression.tail.at(0).head.value.num_value < expression.tail.at(1).head.value.num_value) {
			return Expression(true);
		}
		return Expression(false);
	}
	if (expression.head.value.sym_value == "<=") {
		if (expression.tail.at(0).head.value.num_value <= expression.tail.at(1).head.value.num_value) {
			return Expression(true);
		}
		return Expression(false);
	}
	if (expression.head.value.sym_value == ">") {
		if (expression.tail.at(0).head.value.num_value > expression.tail.at(1).head.value.num_value) {
			return Expression(true);
		}
		return Expression(false);
	}
	if (expression.head.value.sym_value == ">=") {
		if (expression.tail.at(0).head.value.num_value >= expression.tail.at(1).head.value.num_value) {
			return Expression(true);
		}
		return Expression(false);
	}
	if (expression.head.value.sym_value == "=") {
		if (expression.tail.at(0).head.value.num_value == expression.tail.at(1).head.value.num_value) {
			return Expression(true);
		}
		return Expression(false);
	}
	if (expression.head.value.sym_value == "-" && expression.tail.size() == 1) {
		return Expression(0 - expression.tail.at(0).head.value.num_value);
	}
	if (expression.head.value.sym_value == "-") {
		return Expression(expression.tail.at(0).head.value.num_value - expression.tail.at(1).head.value.num_value);
	}
	if (expression.head.value.sym_value == "/") {
		return Expression(expression.tail.at(0).head.value.num_value / expression.tail.at(1).head.value.num_value);
	}
	if (expression.head.value.sym_value == "pow") {
		return Expression(pow(expression.tail.at(0).head.value.num_value, expression.tail.at(1).head.value.num_value));
	}
	if (expression.head.value.sym_value == "not") {
		return Expression(!expression.tail.at(0).head.value.bool_value);
	}
	if (expression.head.value.sym_value == "log10") {
		return Expression(log10(expression.tail.at(0).head.value.num_value));
	}
	for (unsigned int i = 0; i < e.tail.size(); i++) {
		if (expression.head.value.sym_value == "begin") {
				return expression.tail.at(expression.tail.size()-1);
		}
		if (expression.head.value.sym_value == "draw") {
			drawings.push_back(expression.tail.at(i));
		}
		if (expression.head.value.sym_value == "and") {
			if (i == 0) {
				boolResult = true;
			}
			boolResult = expression.tail.at(i).head.value.bool_value && boolResult;
			if (i == e.tail.size() - 1) {
				return Expression(boolResult);
			}
		}
		if (expression.head.value.sym_value == "or") {
			if (i == 0) {
				boolResult = false;
			}
			boolResult = expression.tail.at(i).head.value.bool_value || boolResult;
			if (i == e.tail.size() - 1) {
				return Expression(boolResult);
			}
		}
		if (expression.head.value.sym_value == "+") {
			if (i == 0) {
				num = 0;
			}
			num += expression.tail.at(i).head.value.num_value;
			if (i == e.tail.size() - 1) {
				return Expression(num);
			}
		}
		if (expression.head.value.sym_value == "*") {
			if (i == 0) {
				num = 1;
			}
			num = num * expression.tail.at(i).head.value.num_value;
			if (i == e.tail.size() - 1) {
				return Expression(num);
			}
		}
	}
	if (expression.head.value.sym_value == "draw") {
		return Expression();
	}
	return expression;
}

//This is responsible for all data validation - NOTE it also evaluates expression value for defined symbols and if statments to prevent data type mismatch
//P.S. I know its a super large function, but its nessasary if all error checking is to be done prior to full evaluation
bool Interpreter::errorChecking(Expression & expression)
{
	bool rtn = false;
	if (expression.head.value.sym_value == "sin" && expression.tail.size() != 1) {
		throw(InterpreterSemanticError("Error : Symbol \"sin\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "cos" && expression.tail.size() != 1) {
		throw(InterpreterSemanticError("Error : Symbol \"cos\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "arctan" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \"arctan\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "begin" && expression.tail.empty()) {
		throw(InterpreterSemanticError("Error : Symbol \"begin\" must have at least 1 argument"));
	}
	if (expression.head.value.sym_value == "and" && expression.tail.empty()) {
		throw(InterpreterSemanticError("Error : Symbol \"and\" must have at least 1 argument"));
	}
	if (expression.head.value.sym_value == "or" && expression.tail.empty()) {
		throw(InterpreterSemanticError("Error : Symbol \"or\" must have at least 1 argument"));
	}
	if (expression.head.value.sym_value == "+" && expression.tail.empty()) {
		throw(InterpreterSemanticError("Error : Symbol \"+\" must have at least 1 argument"));
	}
	if (expression.head.value.sym_value == "*" && expression.tail.empty()) {
		throw(InterpreterSemanticError("Error : Symbol \"*\" must have at least 1 argument"));
	}
	if (expression.head.value.sym_value == "if" && expression.tail.size() != 3) {
		throw(InterpreterSemanticError("Error : Symbol \"if\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "not" && expression.tail.size() != 1) {
		throw(InterpreterSemanticError("Error : Symbol \"not\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "log10" && expression.tail.size() != 1) {
		throw(InterpreterSemanticError("Error : Symbol \"log10\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "define" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \"define\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "<" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \"<\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "<=" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \"<=\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == ">" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \">\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == ">=" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \">=\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "=" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \"=\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "/" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \"/\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "pow" && expression.tail.size() != 2) {
		throw(InterpreterSemanticError("Error : Symbol \"pow\" has an invalid number of arguments"));
	}
	if (expression.head.value.sym_value == "-" && (expression.tail.size() > 2 || expression.tail.empty())) {
		throw(InterpreterSemanticError("Error : Symbol \"-\" has an invalid number of arguments"));
	}

	/*Definition evaluation and storage*/
	if (expression.head.value.sym_value == "define") {
		if (expression.tail.at(1).head.type == SymbolType && expression.tail.at(1).head.value.sym_value != "if" 
			&& expression.tail.at(1).head.value.sym_value != "define") {
			try {
				expression.tail.at(1) = env.get(expression.tail.at(1).head.value.sym_value);
			}
			catch (InterpreterSemanticError e) {
			}
		}
		if (expression.tail.at(0).head.type == SymbolType && expression.tail.at(0).head.value.sym_value != "if" 
			&& expression.tail.at(0).head.value.sym_value != "define") {
			if (expression.tail.at(1).head.type == ArcType || expression.tail.at(1).head.type == PointType || expression.tail.at(1).head.type == LineType) {
				env.addExpression(expression.tail.at(0).head.value.sym_value, expression.tail.at(1));
			}
			else {
				env.addExpression(expression.tail.at(0).head.value.sym_value, evaluate(expression.tail.at(1)));
			}
			rtn = true;
		}
		else{
			throw(InterpreterSemanticError("Error : Cannot define symbol \"" + expression.tail.at(0).head.value.sym_value + "\""));
        }
	}

	/*Invalid statments with symbol as head or symbol substitution*/
	if (expression.head.type == SymbolType && expression.head.value.sym_value != "if" && expression.head.value.sym_value != "define") {
		if (!expression.tail.empty()) {
			std::string msg = expression.head.value.sym_value;
			for (unsigned int r = 0; r < expression.tail.size(); r++) {
				msg += " " + expression.tail.at(r).head.value.sym_value;
			}
			throw(InterpreterSemanticError("Error : invalid statment \"" + msg + "\""));
		}
		try {
			expression = env.get(expression.head.value.sym_value);
		}
		catch (InterpreterSemanticError e) {
			throw(InterpreterSemanticError("Error : Symbol \"" + expression.head.value.sym_value + "\" not defined", true));
		}
	}

	for (unsigned int k = 0; k < expression.tail.size(); k++) {
		if (expression.tail.at(k).head.type == SymbolType && expression.tail.at(k).head.value.sym_value != "if" 
			&& expression.tail.at(k).head.value.sym_value != "define" && expression.head.value.sym_value != "define") {
			try {
				expression.tail.at(k) = env.get(expression.tail.at(k).head.value.sym_value);
			}
			catch (InterpreterSemanticError e) {
				throw(InterpreterSemanticError("Error : Symbol \"" + expression.tail.at(k).head.value.sym_value + "\" not defined", true));
			}
		}
		if (expression.head.type == DrawType) {
			if (expression.tail.at(k).head.type != PointType 
				&& expression.tail.at(k).head.type != LineType
				&& expression.tail.at(k).head.type != ArcType) {
				throw(InterpreterSemanticError("Error : Invalid drawing data type"));
			}
		}
		if (expression.head.value.sym_value == "and") {
			if (expression.tail.at(k).head.type != BooleanType) {
				throw(InterpreterSemanticError("Error : Invalid AND statment parameters"));
			}
		}
		else if (expression.head.value.sym_value == "or") {
			if (expression.tail.at(k).head.type != BooleanType) {
				throw(InterpreterSemanticError("Error : Invalid OR statment parameters"));
			}
		}
		else if (expression.head.value.sym_value == "+") {
			if (expression.tail.at(k).head.type != NumberType) {
				throw(InterpreterSemanticError("Error : Invalid arithmatic statment parameters"));
			}
		}
		else if (expression.head.value.sym_value == "*") {
			if (expression.tail.at(k).head.type != NumberType) {
				throw(InterpreterSemanticError("Error : Invalid arithmatic statment parameters"));
			}
		}
	}

	/*If statment substitution for dataType error prevention*/
	if (expression.head.value.sym_value == "if") {
		expression.tail.at(0) = evaluate(expression.tail.at(0));
		if (expression.tail.at(0).head.type != BooleanType) {
			throw(InterpreterSemanticError("Error : Invalid conditional type for if statment"));
		}
		expression = evaluate(expression);
	}
	if (expression.head.value.sym_value == "sin") {
		if (expression.tail.at(0).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid trig parameter data type"));
		}
	}
	if (expression.head.value.sym_value == "cos") {
		if (expression.tail.at(0).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid trig parameter data type"));
		}
	}
	if (expression.head.value.sym_value == "arctan") {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid trig parameter data type"));
		}
		//if (expression.tail.at(1).head.value.num_value == 0) {
		//	throw(InterpreterSemanticError("Error: 'X' value cannot be zero"));
		//}
	}
	if (expression.head.value.sym_value == "<") {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid comparison statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == "<=") {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid comparison statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == ">") {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid comparison statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == ">=") {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid comparison statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == "=") {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid comparison statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == "-" && expression.tail.size() == 2) {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid arithmatic statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == "/") {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid arithmatic statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == "pow") {
		if (expression.tail.at(0).head.type != NumberType || expression.tail.at(1).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid arithmatic statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == "-" && expression.tail.size() == 1) {
		if (expression.tail.at(0).head.type != NumberType) {
			throw(InterpreterSemanticError("Error : Invalid arithmatic negation statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == "not") {
		if (expression.tail.at(0).head.type != BooleanType) {
			throw(InterpreterSemanticError("Error : Invalid boolean negation statment parameters"));
		}
	}
	else if (expression.head.value.sym_value == "log10") {
		if (expression.tail.at(0).head.type == NumberType) {
			if (expression.tail.at(0).head.value.num_value <= 0) {
				throw(InterpreterSemanticError("Error : Logarithms accept only positive values"));
			}
		}
		else {
			throw(InterpreterSemanticError("Error : Invalid logarithmic statment parameters"));
		}
	}
	return rtn;
}

bool Interpreter::parse(std::istream & expression) noexcept {
	errorMessage = std::string();
	ast = Expression();
	Environment tmp = env;
	TokenSequenceType tokens = tokenize(expression);
	int invalid = 0;
	bool valid = true;
	bool startBracket = false;
	for (unsigned int i = 0; i < tokens.size(); i++) {
		if (tokens.at(i) == "("){
			if (startBracket && invalid == 0) {
				errorMessage = "Error : Invalid syntax, try using begin";
				return false;
			}
			if (i == 0) {
				startBracket = true;
			}
			invalid++;
        }
		else if (tokens.at(i) == ")"){
			if (invalid == 0) {
				invalid--;
			}
			invalid--;
        }
	}
	if (invalid != 0) {
		env = tmp;
		errorMessage = "Error : Invalid parentheses";
		return false;
	}
	try {
		std::pair<unsigned int, Expression> expr;
		expr = buildAST(tokens, 0);
		if (expr.second.head.type == NoneType) {
			env = tmp;
			errorMessage = "Error : No entry provided";
			return false;
		}
		ast = expr.second;
	}
	catch (InterpreterSemanticError e) {
		env = tmp;
		env = tmp;
		errorMessage = e.what();
		return !e.getParseError();
	}
	return true;
};

Expression Interpreter::eval() {
	if (!errorMessage.empty()) {
		throw(InterpreterSemanticError(errorMessage));
	}
		return evaluate(ast);
}

Expression Interpreter::popDrawing()
{
	Expression expression = Expression();
	if (!drawings.empty()) {
		expression = drawings.at(0);
		drawings.pop_front();
	}
	return expression;
}

std::string Interpreter::getErrorMessage()
{
	return errorMessage;
}

void Interpreter::clearErrorMessage()
{
	errorMessage.clear();
}
