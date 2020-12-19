#ifndef ENVIRONMENT_HPP
#define ENVIRONMENT_HPP

// system includes
#include <map>

// module includes
#include "expression.hpp"

class Environment {
public:
	Environment();
	void addExpression(Symbol name, Expression exp); //Adds expression to memory, throws error if already exists
	Expression get(Symbol name); //Returns expression if exists else throws error
private:
	// Environment is a mapping from symbols to expressions or procedures
	std::map<Symbol, Expression> envmap;
};

#endif
