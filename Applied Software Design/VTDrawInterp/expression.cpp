#include "expression.hpp"
#include <limits>
#include <cctype>
// system includes
#include <sstream>
#include <float.h>
#include <string>
#include "interpreter_semantic_error.hpp"

Expression::Expression(bool tf){
	head.type = BooleanType;
	head.value.bool_value = tf;
	head.value.num_value = (double)tf;
	if (tf) {
		head.value.sym_value = std::string("True");
	}
	else {
		head.value.sym_value = std::string("False");
	}
	head.value.point_value = std::pair<double, double>(0, 0);
	tail = std::vector<Expression>();
}

Expression::Expression(double num){
	head.type = NumberType;
	head.value.bool_value = (bool)num;
	head.value.num_value = num;
	head.value.sym_value = std::to_string(num);
	head.value.point_value = std::pair<double, double>(0, 0);
	tail = std::vector<Expression>();
}

Expression::Expression(std::tuple<double, double> point) {
	head.type = PointType;
	head.value.point_value = std::pair<double, double>(std::get<0>(point), std::get<1>(point));
	head.value.bool_value = false;
	head.value.num_value = 0;
	head.value.sym_value = "point";
	tail = std::vector<Expression>();
}

Expression::Expression(std::tuple<double, double> point1, std::tuple<double, double> point2) {
	head.type = LineType;
	head.value.point_value = std::pair<double, double>(std::get<0>(point1), std::get<1>(point1));
	head.value.bool_value = false;
	head.value.num_value = 0;
	head.value.sym_value = "line";
	tail = std::vector<Expression>();
	tail.push_back(Expression(point2));
}

Expression::Expression(std::tuple<double, double> center, std::tuple<double, double> arcP, double angle) {
	head.type = ArcType;
	head.value.point_value = std::pair<double, double>(std::get<0>(center), std::get<1>(center));
	head.value.bool_value = false;
	head.value.num_value = 0;
	head.value.sym_value = "arc";
	tail = std::vector<Expression>();
	Expression arcPoint = Expression(arcP);
	Expression angleExpr = Expression(angle);
	tail.push_back(arcPoint);
	tail.push_back(angleExpr);
}

Expression::Expression(const std::string & sym){
	head.type = SymbolType;
	head.value.sym_value = sym;
	double defult = 0;
	defult = std::atoi(sym.c_str());
	head.value.num_value = defult;
	if (sym == "True" || sym == "true") {
		head.value.bool_value = true;
	}
	else {
		head.value.bool_value = false;
	}
	head.value.point_value = std::pair<double, double>(0, 0);
	tail = std::vector<Expression>();
}

bool Expression::operator==(const Expression & exp) const noexcept{
	if (head.type != exp.head.type) {
		return false;
	}
	if (head.type == NoneType) {
		return true;
	}
	if (head.type == PointType) {
		if ((head.value.point_value.first == exp.head.value.point_value.first)
			&& (head.value.point_value.second == exp.head.value.point_value.second)) {
			return true;
		}
	}
	if (head.type == LineType && tail.size() == 1) {
		if ((head.value.point_value.first == exp.head.value.point_value.first)
			&& (head.value.point_value.second == exp.head.value.point_value.second) 
			&& (tail.at(0).head.value.point_value.first == exp.tail.at(0).head.value.point_value.first)
			&& (tail.at(0).head.value.point_value.second == exp.tail.at(0).head.value.point_value.second)) {
			return true;
		}
	}
	if (head.type == ArcType && tail.size() == 2) {
		if (tail.at(0).head.type == PointType && tail.at(1).head.type == NumberType) {
			if ((head.value.point_value.first == exp.head.value.point_value.first)
				&& (head.value.point_value.second == exp.head.value.point_value.second)
				&& (tail.at(0).head.value.point_value.first == exp.tail.at(0).head.value.point_value.first)
				&& (tail.at(0).head.value.point_value.second == exp.tail.at(0).head.value.point_value.second)) {
				return true;
			}
		}
	}
	if (head.type == BooleanType) {
		if (head.value.bool_value == exp.head.value.bool_value) {
			return true;
		}
	}
	if (head.type == NumberType) {
		if (std::abs(head.value.num_value - exp.head.value.num_value) <= std::numeric_limits<double>::epsilon()) {
			return true;
		}
	}
	if (head.type == SymbolType) {
		if (head.value.sym_value == exp.head.value.sym_value) {
			return true;
		}
	}
	return false;
}

std::ostream & operator<<(std::ostream & out, const Expression & exp){
	out << exp.head.value.sym_value;
	return out;
}

bool token_to_atom(const std::string & token, Atom & atom){
	std::stringstream ss(token);
	if (token == "draw" || token == "Draw") {
		atom.type = DrawType;
		atom.value.bool_value = false;
		atom.value.num_value = 0;
		atom.value.sym_value = "draw";
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "True" || token == "true") {
		atom.type = BooleanType;
		atom.value.bool_value = true;
		atom.value.num_value = 1;
		atom.value.sym_value = "True";
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "False" || token == "false") {
		atom.type = BooleanType;
		atom.value.bool_value = false;
		atom.value.num_value = 0;
		atom.value.sym_value = "False";
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "Point" || token == "point") {
		atom.type = PointType;
		atom.value.bool_value = false;
		atom.value.num_value = 0;
		atom.value.sym_value = "point";
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "Line" || token == "line") {
		atom.type = LineType;
		atom.value.bool_value = false;
		atom.value.num_value = 0;
		atom.value.sym_value = "line";
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "Arc" || token == "arc") {
		atom.type = ArcType;
		atom.value.bool_value = false;
		atom.value.num_value = 0;
		atom.value.sym_value = "arc";
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "=" || token == ">" || token == ">=" || token == "<" 
		|| token == "<=" || token == "not" || token == "and" || token == "or") {
		atom.type = BooleanType;
		atom.value.bool_value = false;
		atom.value.num_value = 0;
		atom.value.sym_value = token;
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "pi") {
		atom.type = NumberType;
		atom.value.bool_value = (bool)atan2(0, -1);
		atom.value.num_value = atan2(0, -1);
		atom.value.sym_value = token;
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "+" || token == "-" || token == "*" || token == "/"
		|| token == "log10" || token == "pow" || token == "sin"
		|| token == "cos" || token == "arctan") {
		atom.type = NumberType;
		atom.value.bool_value = false;
		atom.value.num_value = 0;
		atom.value.sym_value = token;
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}
	if (token == "begin") {
		atom.type = ListType;
		atom.value.bool_value = false;
		atom.value.num_value = 0;
		atom.value.sym_value = token;
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}

	/*Checks for valid num including exponential form*/
	bool validNum = true;
	bool numFound = false;
	bool eFound = false;
	bool numSign = false;
	bool decimalPoint = false;
	for (unsigned int i = 0; i < token.size(); i++) {
		bool validExp = true;
		bool expSign = false;
		bool expNum = false;
		if (token.at(i) == 'e' && validNum && !eFound) {
			eFound = true;
			for (unsigned int k = i + 1; k < token.size(); k++) {
				if ((token.at(k) == '+' || token.at(k) == '-') && k == i + 1 && !expSign) {
					expSign = true;
				}
				else if (!((bool)std::isdigit(token.at(k)))) {
					validExp = false;
					break;
				}
				else {
					expNum = true;
				}
			}
			if (!expNum) {
				validExp = false;
			}
		}
		else if (i == 0 && (token.at(i) == '+' || token.at(i) == '-') && !numSign) {
			numSign = true;
		}
		else if (token.at(i) == '.' && !decimalPoint) {
			decimalPoint = true;
		}
		else if (!((bool)std::isdigit(token.at(i)))) {
			validNum = false;
		}
		else {
			numFound = true;
		}
		if ((numFound && validExp && eFound) || (numFound && i == token.size())) {
			break;
		}
		if (!validExp || (eFound && !numFound)) {
			validNum = false;
			break;
		}
	}
	if (validNum) {
		atom.type = NumberType;
		ss >> atom.value.num_value;
		atom.value.bool_value = (bool)atom.value.num_value;
		atom.value.sym_value = token;
		atom.value.point_value = std::pair<double, double>(0., 0.);
		return true;
	}

	//If it isn't num then check for valid symbol
	if ((bool)std::isdigit(token.at(0))) {
		atom.value.sym_value = "Error : Symbols cannot start with a digit";
		return false;
	}
	atom.type = SymbolType;
	atom.value.bool_value = false;
	atom.value.num_value = 0;
	atom.value.sym_value = token;
	atom.value.point_value = std::pair<double, double>(0., 0.);
	return true;
}

