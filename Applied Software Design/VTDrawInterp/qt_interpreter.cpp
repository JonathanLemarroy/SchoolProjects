#include "qt_interpreter.hpp"

#include <string>
#include <sstream>
#include <iostream>
//#include <QtMath>
#include <cmath>
#include <fstream>
#include <QRect>

#include <QBrush>

#include "qgraphics_arc_item.hpp"

#include "interpreter_semantic_error.hpp"

QtInterpreter::QtInterpreter(QObject * parent) : QObject(parent) {
	interp = Interpreter();
}

void QtInterpreter::parseAndEvaluate(QString entry) {
	std::istringstream iss(entry.toStdString());
	interp.parse(iss);
	if (interp.getErrorMessage().empty()) {
		Expression result = interp.eval();
		Expression drawing = interp.popDrawing();
		bool drawn = false;
		while (!(drawing == Expression()) && interp.getErrorMessage().empty()) {
			if (drawing.head.type == PointType) {
				QGraphicsPointItem *point = new QGraphicsPointItem(drawing.head.value.point_value.first-2, drawing.head.value.point_value.second-2, 4, 4);
				emit drawGraphic(point);
			}
			else if (drawing.head.type == LineType) {
				QGraphicsLineItem *line = new QGraphicsLineItem(drawing.head.value.point_value.first,
					drawing.head.value.point_value.second, drawing.tail.at(0).head.value.point_value.first,
					drawing.tail.at(0).head.value.point_value.second);
				emit drawGraphic(line);
			}
			else if (drawing.head.type == ArcType) {
				double xRange = drawing.tail.at(0).head.value.point_value.first - drawing.head.value.point_value.first;
				double yRange = drawing.tail.at(0).head.value.point_value.second - drawing.head.value.point_value.second;
				double radius = sqrt(pow(xRange, 2) + pow(yRange, 2));
				QGraphicsArcItem *arc = new QGraphicsArcItem(drawing.head.value.point_value.first - radius, drawing.head.value.point_value.second - radius, radius*2.0, radius*2.0);

				double startAngle = atan2(-1 * yRange, xRange);
				startAngle = startAngle * 180 / atan2(0, -1) * 16;
				double spanAngle = drawing.tail.at(1).head.value.num_value * 180 / atan2(0, -1) * 16;
				arc->setStartAngle(startAngle);
				arc->setSpanAngle(spanAngle);
				emit drawGraphic(arc);
			}
			drawing = interp.popDrawing();
		}
		if (result == Expression()) {
			emit info("Item(s) Drawn");
			interp.clearErrorMessage();
		}
		else {
			QString str = QString::fromStdString(result.head.value.sym_value);
			emit info(str);
			interp.clearErrorMessage();
		}
	}
	else {
		QString str = QString::fromStdString(interp.getErrorMessage());
		emit error(str);
		interp.clearErrorMessage();
	}
}
