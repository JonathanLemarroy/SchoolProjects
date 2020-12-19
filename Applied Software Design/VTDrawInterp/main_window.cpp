#include "main_window.hpp"

#include <iostream>
#include <fstream>
#include <sstream>

#include <QLayout>

#include "interpreter_semantic_error.hpp"

MainWindow::MainWindow(QWidget * parent) : MainWindow("", parent) {
}

MainWindow::MainWindow(std::string filename, QWidget * parent) : QWidget(parent) {
	layout = new QVBoxLayout(this);
	interp = new QtInterpreter(this);
	msgBox = new MessageWidget(this);
	entryBox = new REPLWidget(this);
	canvas = new CanvasWidget(this);
	layout->addWidget(msgBox);
	layout->addWidget(canvas);
	layout->addWidget(entryBox);
	layout->setAlignment(Qt::AlignHCenter);
	//canvas->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
	connect(entryBox, &REPLWidget::lineEntered, interp, &QtInterpreter::parseAndEvaluate);
	connect(interp, &QtInterpreter::drawGraphic, canvas, &CanvasWidget::addGraphic);
	connect(interp, &QtInterpreter::info, msgBox, &MessageWidget::info);
	connect(interp, &QtInterpreter::error, msgBox, &MessageWidget::error);
	connect(this, &MainWindow::resizeEvent, canvas, &CanvasWidget::adjustSize);
	if (!filename.empty()) {
		std::ifstream inFile;
		inFile.open(filename);
		if (inFile.is_open()) {
			std::stringstream buffer;
			buffer << inFile.rdbuf();
			QString input = QString::fromStdString(buffer.str());
			interp->parseAndEvaluate(input);
		}
		else {
			msgBox->error("Error : Unable to open file");
		}
	}
}
