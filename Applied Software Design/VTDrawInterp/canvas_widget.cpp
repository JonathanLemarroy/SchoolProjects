#include "canvas_widget.hpp"

CanvasWidget::CanvasWidget(QWidget * parent): QWidget(parent){
	view = new QGraphicsView(this);
	scene = new QGraphicsScene(this);
	view->setScene(scene);
	view->show();
	view->setAlignment(Qt::AlignCenter);
	this->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
	view->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
}

void CanvasWidget::addGraphic(QGraphicsItem * item){
	scene->addItem(item);

}

void CanvasWidget::adjustSize(QResizeEvent * evnt)
{
	this->setFixedHeight(evnt->size().height() - 200);
	this->setFixedWidth(evnt->size().width() - 50);
	view->setFixedHeight(this->height());
	view->setFixedWidth(this->width());
}
