#include "tokenize.hpp"
#include <cctype>
#include <string>
#include <iostream>

TokenSequenceType tokenize(std::istream & seq){
	TokenSequenceType tokens;
	std::string line;
	std::string token;
	while (std::getline(seq, line)) {
		for (unsigned int i = 0; i < line.length(); i++) {
			if (line.at(i) == OPEN) {
				if (!token.empty()){
					tokens.push_back(token);
					token = std::string();
                }
				token.push_back(OPEN);
				tokens.push_back(token);
				token = std::string();
			}
			else if (line.at(i) == CLOSE) {
				if (!token.empty()){
					tokens.push_back(token);
                }
				token = std::string();
				token.push_back(CLOSE);
				tokens.push_back(token);
				token = std::string();
			}
			else if (line.at(i) == COMMENT) {
				if (!token.empty()) {
					tokens.push_back(token);
					token = std::string();
				}
				break;
			}
			else if (line.at(i) == '\n' || line.at(i) == '\t' || line.at(i) == '\r') {

			}
			else if (line.at(i) == ' ') {
				if (!token.empty()){
					tokens.push_back(token);
					token = std::string();
                }
			}
			else {
				token.push_back(line.at(i));
				if (i == line.length() - 1) { //Inserts last token
					tokens.push_back(token);
					token = std::string();
				}
			}
		}
	}
	return tokens;
}
