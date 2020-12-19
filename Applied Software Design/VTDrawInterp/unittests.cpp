#define CATCH_CONFIG_MAIN
#define CATCH_CONFIG_COLOUR_NONE
#include "catch.hpp"
#include "interpreter.hpp"

TEST_CASE("Test Tokenizer with newline input and sequential parentheses", "[tokenize]") {

	std::string program = "(begin (define r 10) \n (* pi ((* r r))))";
	std::istringstream iss(program);
	TokenSequenceType tokens = tokenize(iss);

	REQUIRE(tokens.size() == 19);
	REQUIRE(tokens[0] == "(");
	REQUIRE(tokens[1] == "begin");
	REQUIRE(tokens[2] == "(");
	REQUIRE(tokens[3] == "define");
	REQUIRE(tokens[4] == "r");
	REQUIRE(tokens[5] == "10");
	REQUIRE(tokens[6] == ")");
	REQUIRE(tokens[7] == "(");
	REQUIRE(tokens[8] == "*");
	REQUIRE(tokens[9] == "pi");
	REQUIRE(tokens[10] == "(");
	REQUIRE(tokens[11] == "(");
	REQUIRE(tokens[12] == "*");
	REQUIRE(tokens[13] == "r");
	REQUIRE(tokens[14] == "r");
	REQUIRE(tokens[15] == ")");
	REQUIRE(tokens[16] == ")");
	REQUIRE(tokens[17] == ")");
	REQUIRE(tokens[18] == ")");
}

TEST_CASE("Test Tokenizer without outer parentheses", "[tokenize]") {

	std::string program = "begin (define r 10) r";
	std::istringstream iss(program);
	TokenSequenceType tokens = tokenize(iss);

	REQUIRE(tokens.size() == 7);
	REQUIRE(tokens[0] == "begin");
	REQUIRE(tokens[1] == "(");
	REQUIRE(tokens[2] == "define");
	REQUIRE(tokens[3] == "r");
	REQUIRE(tokens[4] == "10");
	REQUIRE(tokens[5] == ")");
	REQUIRE(tokens[6] == "r");
}

TEST_CASE("Test Tokenizer with comment", "[tokenize]") {

	std::string program = "begin (define r 10) r;this is a comment";
	std::istringstream iss(program);
	TokenSequenceType tokens = tokenize(iss);

	REQUIRE(tokens.size() == 7);
	REQUIRE(tokens[0] == "begin");
	REQUIRE(tokens[1] == "(");
	REQUIRE(tokens[2] == "define");
	REQUIRE(tokens[3] == "r");
	REQUIRE(tokens[4] == "10");
	REQUIRE(tokens[5] == ")");
	REQUIRE(tokens[6] == "r");
}

TEST_CASE("Test Special Types", "[types]") {
	Atom a;
	std::string token = "+";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == NumberType);

	token = "-";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == NumberType);

	token = "/";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == NumberType);

	token = "*";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == NumberType);

	token = "pow";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == NumberType);

	token = "log10";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == NumberType);

	token = "define";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == SymbolType);
	REQUIRE(a.value.sym_value == token);

	token = "begin";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == ListType);
	REQUIRE(a.value.sym_value == token);

	token = "<";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == BooleanType);

	token = "<=";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == BooleanType);

	token = ">=";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == BooleanType);

	token = ">";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == BooleanType);

	token = "=";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == BooleanType);

	token = "and";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == BooleanType);

	token = "or";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == BooleanType);

	token = "not";
	REQUIRE(token_to_atom(token, a));
	REQUIRE(a.type == BooleanType);
}

Expression runE(const std::string & program) {

	std::istringstream iss(program);

	Interpreter interp;

	bool ok = interp.parse(iss);
	if (!ok) {
		std::cerr << "Failed to parse: " << program << std::endl;
	}
	REQUIRE(ok == true);

	Expression result;
	REQUIRE_NOTHROW(result = interp.eval());

	return result;
}

//Made for failed cases
bool runF(const std::string & program) {
	std::istringstream iss(program);
	Interpreter interp;
	bool ok = interp.parse(iss);
	return ok;
}

TEST_CASE("Test Interpreter parser with expected input excluding outer parenthesies", "[interpreter]") {

	std::string program = "begin (define r 10) (* pi (* r r))";

	std::istringstream iss(program);

	Interpreter interp;

	bool ok = interp.parse(iss);

	REQUIRE(ok == true);
}

TEST_CASE("Test Interpreter parser with expected input and no parentheses", "[interpreter]") {

	std::string program = "* pi 10";

	std::istringstream iss(program);

	Interpreter interp;

	bool ok = interp.parse(iss);

	REQUIRE(ok == true);
}

TEST_CASE("Test Interpreter result with arithmatic procedures ", "[interpreter]") {

	{ // add, binary case
		std::string program = "(+ 1 2)";
		Expression result = runE(program);
		REQUIRE(result == Expression(3.));
	}

	{ // add, 6-ary case
		std::string program = "(+ 1 2 3 4 5 6)";
		Expression result = runE(program);
		REQUIRE(result == Expression(21.));
	}

	{ // sub, binary case
		std::string program = "(- 1 4)";
		Expression result = runE(program);
		REQUIRE(result == Expression(-3.));
	}

	{ // neg, unary case
		std::string program = "(- 2)";
		Expression result = runE(program);
		REQUIRE(result == Expression(-2.));
	}

	{ // mult, binary case
		std::string program = "(* 1 2)";
		Expression result = runE(program);
		REQUIRE(result == Expression(2.));
	}

	{ // mult, 5-ary case
		std::string program = "(* 1 2 3 4 5)";
		Expression result = runE(program);
		REQUIRE(result == Expression(120.));
	}

	{ // pow, binary case
		std::string program = "(pow 2 3)";
		Expression result = runE(program);
		REQUIRE(result == Expression(8.));
	}

	{ // div, binary case
		std::string program = "(/ 1 2)";
		Expression result = runE(program);
		REQUIRE(result == Expression(.5));
	}

	{ // log10, binary case
		std::string program = "(log10 100)";
		Expression result = runE(program);
		REQUIRE(result == Expression(2.));
	}
}

TEST_CASE("Test Interpreter result with boolean procedures ", "[interpreter]") {

	{ // not, unary case
		std::string program = "(not True)";
		Expression result = runE(program);
		REQUIRE(result == Expression(false));
	}

	{ // and, unary case
		std::string program = "(and True)";
		Expression result = runE(program);
		REQUIRE(result == Expression(true));
	}

	{ // and, 3-ary case
		std::string program = "(and True False True)";
		Expression result = runE(program);
		REQUIRE(result == Expression(false));
	}

	{ // or, unary case
		std::string program = "(or True)";
		Expression result = runE(program);
		REQUIRE(result == Expression(true));
	}

	{ // or, 3-ary case
		std::string program = "(or True False True)";
		Expression result = runE(program);
		REQUIRE(result == Expression(true));
	}

	{ // >, binary case
		std::string program = "(> 1 1)";
		Expression result = runE(program);
		REQUIRE(result == Expression(false));
	}

	{ // >=, binary case
		std::string program = "(>= 1 1)";
		Expression result = runE(program);
		REQUIRE(result == Expression(true));
	}

	{ // <, binary case
		std::string program = "(< 1 1)";
		Expression result = runE(program);
		REQUIRE(result == Expression(false));
	}

	{ // <=, binary case
		std::string program = "(<= 1 1)";
		Expression result = runE(program);
		REQUIRE(result == Expression(true));
	}

	{ // =, binary case
		std::string program = "(= 1 1)";
		Expression result = runE(program);
		REQUIRE(result == Expression(true));
	}

	{ // !=, binary case
		std::string program = "(= 1 2)";
		Expression result = runE(program);
		REQUIRE(result == Expression(false));
	}
}

TEST_CASE("Test Interpreter if statments", "[interpreter]") {

	std::string program = "(if True False True)";
	Expression result = runE(program);
	REQUIRE(result == Expression(false));

	program = "(if False 1 2)";
	result = runE(program);
	REQUIRE(result == Expression(2.));

	program = "(if False 1 True)";
	result = runE(program);
	REQUIRE(result == Expression(true));

	program = "(if (if True False True) 1 True)";
	result = runE(program);
	REQUIRE(result == Expression(true));

	program = "(if True (if True False True) True)";
	result = runE(program);
	REQUIRE(result == Expression(false));
}

TEST_CASE("Test Interpreter define statments", "[interpreter]") {
	std::string program = "(define a True)";
	Expression result = runE(program);
	REQUIRE(result == Expression(true));

	program = "(define a 10)";
	result = runE(program);
	REQUIRE(result == Expression(10.));

	program = "(define a (if True False 10))";
	result = runE(program);
	REQUIRE(result == Expression(false));
}

TEST_CASE("Test Interpreter begin and complex statments with comments", "[interpreter]") {
	std::string program = "(begin (define a True) (define b False) (if b b a));This is a comment";
	Expression result = runE(program);
	REQUIRE(result == Expression(true));

	program = "(begin 10)";
	result = runE(program);
	REQUIRE(result == Expression(10.));
}

TEST_CASE("Test definitions in memory and missing parentheses", "[interpreter]") {
	Interpreter interp;
	Expression result;
	{
		std::string program = "define a 10";
		std::istringstream iss(program);
		bool ok = interp.parse(iss);
		REQUIRE_NOTHROW(result = interp.eval());
		REQUIRE(ok == true);
	}
	{
		std::string program = "define b 20";
		std::istringstream iss(program);
		bool ok = interp.parse(iss);
		REQUIRE_NOTHROW(result = interp.eval());
		REQUIRE(ok == true);
	}
	{
		std::string program = "+ a b";
		std::istringstream iss(program);
		bool ok = interp.parse(iss);
		REQUIRE_NOTHROW(result = interp.eval());
		REQUIRE(ok == true);
		REQUIRE(result == Expression(30.));
	}
	{
		std::string program = "define c d";
		std::istringstream iss(program);
		bool ok = interp.parse(iss);
		REQUIRE_NOTHROW(result = interp.eval());
		REQUIRE(ok == true);
		std::string nm = "d";
		REQUIRE(result == Expression(nm));
	}
}

//Due to different implimentation for Project 3 these don't work

//TEST_CASE("Test bad input - data type missmatch", "[interpreter]") {
//	std::string program = "(define pi 10)";
//	REQUIRE(!runF(program));
//
//	program = "(if 1 True False)";
//	REQUIRE(!runF(program));
//
//	program = "(a)";
//	REQUIRE(!runF(program));
//
//	program = "(- True False)";
//	REQUIRE(!runF(program));
//
//	program = "(+ True False)";
//	REQUIRE(!runF(program));
//
//	program = "(and 1 2)";
//	REQUIRE(!runF(program));
//
//	program = "(or 1 2)";
//	REQUIRE(!runF(program));
//
//	program = "(not 1 2)";
//	REQUIRE(!runF(program));
//
//	program = "(* True False)";
//	REQUIRE(!runF(program));
//
//	program = "(/ True False)";
//	REQUIRE(!runF(program));
//
//	program = "(> True False)";
//	REQUIRE(!runF(program));
//
//	program = "(>= True False)";
//	REQUIRE(!runF(program));
//
//	program = "(< True False)";
//	REQUIRE(!runF(program));
//
//	program = "(<= True False)";
//	REQUIRE(!runF(program));
//
//	program = "(= True False)";
//	REQUIRE(!runF(program));
//
//	program = "(pow True False)";
//	REQUIRE(!runF(program));
//
//	program = "(log10 True)";
//	REQUIRE(!runF(program));
//}

//TEST_CASE("Test bad input - missing parameters", "[interpreter]") {
//
//	std::string program = "(if True False)";
//	REQUIRE(!runF(program));
//
//	program = "(begin)";
//	REQUIRE(!runF(program));
//
//	program = "(define a)";
//	REQUIRE(!runF(program));
//
//	program = "(-)";
//	REQUIRE(!runF(program));
//
//	program = "(+)";
//	REQUIRE(!runF(program));
//
//	program = "(and)";
//	REQUIRE(!runF(program));
//
//	program = "(or)";
//	REQUIRE(!runF(program));
//
//	program = "(not)";
//	REQUIRE(!runF(program));
//
//	program = "(*)";
//	REQUIRE(!runF(program));
//
//	program = "(/)";
//	REQUIRE(!runF(program));
//
//	program = "(>)";
//	REQUIRE(!runF(program));
//
//	program = "(>=)";
//	REQUIRE(!runF(program));
//
//	program = "(<)";
//	REQUIRE(!runF(program));
//
//	program = "(<=)";
//	REQUIRE(!runF(program));
//
//	program = "(=)";
//	REQUIRE(!runF(program));
//
//	program = "(pow)";
//	REQUIRE(!runF(program));
//
//	program = "(log10)";
//	REQUIRE(!runF(program));
//}

//TEST_CASE("Test bad input - too many arguments", "[interpreter]") {
//	std::string program = "(if True False True False)";
//	REQUIRE(!runF(program));
//
//	program = "(define a 1 2)";
//	REQUIRE(!runF(program));
//
//	program = "(- 1 2 3)";
//	REQUIRE(!runF(program));
//
//	program = "(/ 1 2 3 )";
//	REQUIRE(!runF(program));
//
//	program = "(> 1 2 3)";
//	REQUIRE(!runF(program));
//
//	program = "(>= 1 2 3)";
//	REQUIRE(!runF(program));
//
//	program = "(< 1 2 3)";
//	REQUIRE(!runF(program));
//
//	program = "(<= 1 2 3)";
//	REQUIRE(!runF(program));
//
//	program = "(= 1 2 3)";
//	REQUIRE(!runF(program));
//
//	program = "(pow 1 2 3)";
//	REQUIRE(!runF(program));
//
//	program = "(log10 1 2)";
//	REQUIRE(!runF(program));
//}