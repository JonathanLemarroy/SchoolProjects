#ifndef INTERPRETER_SEMANTIC_ERROR_HPP
#define INTERPRETER_SEMANTIC_ERROR_HPP

#include <exception>
#include <stdexcept>

class InterpreterSemanticError: public std::runtime_error {
public:
  InterpreterSemanticError(const std::string& message): std::runtime_error(message){};
  InterpreterSemanticError(const std::string& message, bool isParseError) : std::runtime_error(message) { parseError = isParseError; };
  bool getParseError(){
      return parseError;
  };
private:
    bool parseError = false;
};

#endif
