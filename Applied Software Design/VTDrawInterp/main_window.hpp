#ifndef MAIN_WINDOW_HPP
#define MAIN_WINDOW_HPP

#include <string>

#include <QWidget>
#include <QLayout>
#include <QResizeEvent>

#include "qt_interpreter.hpp"
#include "repl_widget.hpp"
#include "canvas_widget.hpp"
#include "message_widget.hpp"


class MainWindow : public QWidget {
	Q_OBJECT

public:
	MainWindow(QWidget * parent = nullptr);
	MainWindow(std::string filename, QWidget * parent = nullptr);

signals:
	void resizeEvent(QResizeEvent *evnt);

private:
	QVBoxLayout *layout;
	QtInterpreter *interp;
	MessageWidget *msgBox;
	REPLWidget *entryBox;
	CanvasWidget *canvas;
};


#endif
