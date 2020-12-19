#include "qgraphics_arc_item.hpp"

#include <cmath>

#include <QDebug>
#include <QPainter>

QGraphicsArcItem::QGraphicsArcItem(qreal x, qreal y, qreal width, qreal height, QGraphicsItem *parent) : QGraphicsEllipseItem(x, y, width, height, parent) {
	
}
void QGraphicsArcItem::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget) {
	painter->drawArc(this->rect(), this->startAngle(), this->spanAngle());
}

QGraphicsPointItem::QGraphicsPointItem(qreal x, qreal y, qreal width, qreal height, QGraphicsItem * parent) : QGraphicsEllipseItem(x, y, width, height, parent)
{
}

void QGraphicsPointItem::paint(QPainter * painter, const QStyleOptionGraphicsItem * option, QWidget * widget)
{
	painter->setBrush(QBrush(Qt::black));
	painter->drawEllipse(this->rect());
}
