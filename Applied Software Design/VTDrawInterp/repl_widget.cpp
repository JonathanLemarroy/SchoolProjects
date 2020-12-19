#include "repl_widget.hpp"

REPLWidget::REPLWidget(QWidget * parent) : QWidget(parent) {
	index = -1;
	commands = QList<QString>();
	label = new QLabel(this);
	msgBox = new QLineEdit(this);
	label->setFixedHeight(30);
	msgBox->setFixedHeight(30);
	layout = new QHBoxLayout(this);
	label->setText("vtscript>");
	msgBox->setPlaceholderText("Enter command here...");
	layout->addWidget(label);
	layout->addWidget(msgBox);
	layout->setAlignment(Qt::AlignBottom);
}
void REPLWidget::keyPressEvent(QKeyEvent *evnt) {

	if (evnt->key() == Qt::Key_Up) {
		if (index > 0) {
			index--;
		}
		if (!commands.isEmpty()) {
			msgBox->setText(commands.at(index));
		}
	}
	else if (evnt->key() == Qt::Key_Down) {
		if (index < commands.size() - 1)
			index++;
		if (!commands.isEmpty()) {
			msgBox->setText(commands.at(index));
		}
	}
	else if (evnt->key() == Qt::Key_Enter || evnt->key() == Qt::Key_Return) {
		emit lineEntered(msgBox->text());
		commands.push_back(msgBox->text());
		msgBox->clear();
		index++;
	}
}


