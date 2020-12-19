#include <cstdlib>
#include "interpreter.hpp"
#include <istream>
#include <iostream>
#include <sstream>
#include <string>
#include <fstream>

int main(int argc, char **argv)
{
	Interpreter interp = Interpreter();
	try {
		int rtn = EXIT_FAILURE;
		if (argc == 1) { //Continous user input program
			std::cout << "vtscript> ";
			std::string str;
			while (std::getline(std::cin, str)) {
				if (str.empty()) {
					std::cout << "vtscript> ";
					continue;
				}
				std::istringstream strm(str);
				bool wasValid = interp.parse(strm);
				if (wasValid && interp.getErrorMessage().empty()) {
					//std::cout << std::endl;
					Expression exp = interp.eval();
					if (exp.head.type == NumberType) {
						std::cout << "(" << exp.head.value.num_value << ")";
					}
					else if (exp.head.type == SymbolType) {
						std::cout << "(" << exp.head.value.sym_value << ")";
					}
					else if (exp.head.type == BooleanType && exp.head.value.bool_value) {
						std::cout << "(True)";
					}
					else if (exp.head.type == BooleanType && !exp.head.value.bool_value) {
						std::cout << "(False)";
					}
				}
				else {
					std::cout << interp.getErrorMessage() << std::endl;
					interp.clearErrorMessage();
				}
				std::cout << std::endl;
				std::cout << "vtscript> ";
			}
			//system("pause");
			rtn = EXIT_SUCCESS;
		}
		else if (argc == 2) { //File input program
			std::string fileName(argv[1]);
			std::ifstream inFile;
			inFile.open(fileName);
			if (inFile.is_open()) {
				bool wasValid = interp.parse(inFile);
				if (wasValid && interp.getErrorMessage().empty()) {
					Expression exp = interp.eval();
					if (exp.head.type == NumberType) {
						std::cout << "(" << exp.head.value.num_value << ")";
					}
					else if (exp.head.type == SymbolType) {
						std::cout << "(" << exp.head.value.sym_value << ")";
					}
					else if (exp.head.type == BooleanType && exp.head.value.bool_value) {
						std::cout << "(True)";
					}
					else if (exp.head.type == BooleanType && !exp.head.value.bool_value) {
						std::cout << "(False)";
					}
					std::cout << std::endl;
					//system("pause");
					rtn = EXIT_SUCCESS;
				}
				else {
					std::cout << interp.getErrorMessage() << std::endl;
					//system("pause");
					rtn = EXIT_FAILURE;
				}
			}
			else {
				std::cout << "Error : File could not be openend" << std::endl;
				//system("pause");
				rtn = EXIT_FAILURE;
			}
		}
		else if (argc == 3) { //Single command user input program
			if (argv[1] == std::string("-e")) {
				std::istringstream str(argv[2]);
				bool wasValid = interp.parse(str);
				if (wasValid && interp.getErrorMessage().empty()) {
					Expression exp = interp.eval();
					if (exp.head.type == NumberType) {
						std::cout << "(" << exp.head.value.num_value << ")";
					}
					else if (exp.head.type == SymbolType) {
						std::cout << "(" << exp.head.value.sym_value << ")";
					}
					else if (exp.head.type == BooleanType && exp.head.value.bool_value) {
						std::cout << "(True)";
					}
					else if (exp.head.type == BooleanType && !exp.head.value.bool_value) {
						std::cout << "(False)";
					}
					std::cout << std::endl;
					//system("pause");
					rtn = EXIT_SUCCESS;
				}
				else {
					std::cout << interp.getErrorMessage() << std::endl;
					//system("pause");
					rtn = EXIT_FAILURE;
				}
			}
			else {
				std::cout << "Error : Invalid program parameters" << std::endl;
				//system("pause");
				rtn = EXIT_FAILURE;
			}
		}
		if (rtn == EXIT_FAILURE) {
			std::cout << "Error : Invalid program parameters" << std::endl;
			//system("pause");
		}
		return rtn;
	}
	catch (std::exception e) {
		std::cout << interp.getErrorMessage();
		return EXIT_FAILURE;
	}
}
