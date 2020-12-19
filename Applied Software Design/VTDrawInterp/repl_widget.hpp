#ifndef REPL_WIDGET_HPP
#define REPL_WIDGET_HPP

#include <QWidget>
#include <QLineEdit>
#include <QString>
#include <QList>
#include <QLabel>
#include <QLayout>
#include <QKeyEvent>

class REPLWidget : public QWidget {
	Q_OBJECT

public:

	REPLWidget(QWidget * parent = nullptr);

signals:

	void lineEntered(QString entry);

private slots:

	void keyPressEvent(QKeyEvent *evnt);

private:

	QHBoxLayout *layout;
	QLabel *label;
	QLineEdit *msgBox;
	QList<QString> commands;
	int index;
};

#endif
