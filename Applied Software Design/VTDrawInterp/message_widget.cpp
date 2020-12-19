#include "message_widget.hpp"


MessageWidget::MessageWidget(QWidget *parent) : QWidget(parent) {
	msgBox = new QLineEdit(this);
	label = new QLabel(this);
	label->setFixedHeight(30);
	msgBox->setFixedHeight(30);
	layout = new QHBoxLayout(this);
	label->setText("Message: ");
	msgBox->setReadOnly(true);
	layout->addWidget(label);
	layout->addWidget(msgBox);
	layout->setAlignment(Qt::AlignTop);
}

void MessageWidget::info(QString message) {
	QPalette palette = msgBox->palette();
	palette.setColor(QPalette::Highlight, Qt::blue);
	palette.setColor(QPalette::HighlightedText, Qt::white);
	msgBox->setPalette(palette);
	msgBox->setText("(" + message + ")");
	msgBox->deselect();
}

void MessageWidget::error(QString message) {
	QPalette palette = msgBox->palette();
	palette.setColor(QPalette::Highlight, Qt::red);
	palette.setColor(QPalette::HighlightedText, Qt::black);
	msgBox->setPalette(palette);
	msgBox->setText(message);
	msgBox->selectAll();
}

void MessageWidget::clear() {
	msgBox->setText("");
}
