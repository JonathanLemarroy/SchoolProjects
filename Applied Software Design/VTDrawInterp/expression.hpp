#ifndef TYPES_HPP
#define TYPES_HPP

// system includes
#include <string>
#include <vector>
#include <tuple>
#include <cmath>
// A Type is a literal boolean, literal number, or symbol
enum Type {NoneType, BooleanType, NumberType, ListType, SymbolType, PointType, LineType, ArcType, DrawType};

// A Boolean is a C++ bool
typedef bool Boolean;

// A Number is a C++ double
typedef double Number;

// A Symbol is a string
typedef std::string Symbol;

typedef std::pair<double, double> Point;

// A Value is a boolean, number, or symbol
// cannot use a union because symbol is non-POD
// this wastes space but is simple 
struct Value {
  Boolean bool_value;
  Number num_value;
  Symbol sym_value;
  Point point_value;
};
  
// An Atom has a type and value
struct Atom{
  Type type;
  Value value;
};

// An expression is an atom called the head
// followed by a (possibly empty) list of expressions
// called the tail
struct Expression{
  Atom head;
  std::vector<Expression> tail;

  Expression() {
    head.type = NoneType;
	head.value.bool_value = false;
	head.value.num_value = 0;
	head.value.sym_value = "";
	head.value.point_value = std::pair<double, double>(0,0);
  };

  Expression(const Atom & atom): head(atom){};
  Expression(bool tf);
  Expression(double num);
  Expression(std::tuple<double, double> point);
  Expression(std::tuple<double, double> point1, std::tuple<double, double> point2);
  Expression(std::tuple<double, double> center, std::tuple<double, double> arcP, double angle);
  Expression(const std::string & sym);

  bool operator==(const Expression & exp) const noexcept;
};


// A Procedure is a C++ function pointer taking
// a vector of Atoms as arguments
typedef Expression (*Procedure)(const std::vector<Atom> & args);

// format an expression for output
std::ostream & operator<<(std::ostream & out, const Expression & exp);

// map a token to an Atom
bool token_to_atom(const std::string & token, Atom & atom);
#endif
