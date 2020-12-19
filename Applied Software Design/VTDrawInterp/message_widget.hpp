#ifndef MESSAGE_WINDOW_HPP
#define MESSAGE_WINDOW_HPP

#include <QString>
#include <QWidget>
#include <QLabel>
#include <QLayout>
#include <QLineEdit>
#include <QPalette>
#include <QBrush>
#include <QColor>

class QLineEdit;

class MessageWidget : public QWidget {
	Q_OBJECT

public:
	MessageWidget(QWidget *parent = nullptr);

public slots:

	void info(QString message);

	void error(QString message);

	void clear();

private:
	QHBoxLayout *layout;
	QLabel *label;
	QLineEdit *msgBox;
};

#endif
