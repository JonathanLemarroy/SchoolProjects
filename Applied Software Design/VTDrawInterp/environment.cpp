#include "environment.hpp"

#include <cassert>
#include <cmath>

#include "interpreter_semantic_error.hpp"

Environment::Environment(){
	envmap = std::map<Symbol, Expression>();
}


void Environment::addExpression(Symbol name, Expression exp)
{
	if (envmap.find(name) != envmap.end()) {
		throw(InterpreterSemanticError("Error: Redefinition of \"" + name + "\" not allowed"));
	}
	envmap.insert(std::pair<Symbol, Expression>(name, exp));
}

Expression Environment::get(Symbol name)
{
	if (envmap.find(name) != envmap.end()) {
		return envmap[name];
	}
	throw(InterpreterSemanticError("Error: variable \"" + name + "\" never intialized"));
}


