#include <QPainter>
#include <QPainterPath>
#include <QBrush>
#include <QHBoxLayout>

#include "dmenubase.h"
#include "ddesktopmenu.h"
#include "dmenucontent.h"

DDesktopMenu::DDesktopMenu():
    DMenuBase()
{
    this->setShadowMargins(QMargins(10, 10, 10, 10));
    this->setContentsMargins(QMargins(10, 10, 10, 10));
    this->setItemLeftSpacing(10);
    this->setItemCenterSpacing(10);
    this->setItemRightSpacing(10);

    DMenuContent *content = new DMenuContent(this);
    this->resize(content->contentWidth()
                 + this->shadowMargins().left()
                 + this->shadowMargins().right()
                 + this->contentsMargins().left()
                 + this->contentsMargins().right(),
                 content->contentHeight()
                 + this->shadowMargins().top()
                 + this->shadowMargins().bottom()
                 + this->contentsMargins().top()
                 + this->contentsMargins().bottom());

    QHBoxLayout *layout = new QHBoxLayout(this);
    layout->setContentsMargins(this->contentsMargins());
    layout->addWidget(content);

    this->setLayout(layout);
}

// override methods
void DDesktopMenu::paintEvent(QPaintEvent * event)
{
    QRect rect = this->rect().marginsRemoved(shadowMargins());

    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing);

    QPainterPath border;
    border.addRoundedRect(rect, radius(), radius());

    painter.fillPath(border, QBrush(Qt::white));
}

void DDesktopMenu::setItemState(ItemState state)
{
    switch (state) {
    case DDesktopMenu::NormalState:
        this->setItemBackgroundColor(Qt::transparent);
        this->setItemTextColor(Qt::black);
        this->setItemShortcutColor(Qt::black);
        break;
    case DDesktopMenu::HoverState:
        this->setItemBackgroundColor(Qt::gray);
        this->setItemTextColor(Qt::white);
        this->setItemShortcutColor(Qt::white);
        break;
    case DDesktopMenu::InactiveState:
        this->setItemBackgroundColor(Qt::transparent);
        this->setItemTextColor(Qt::gray);
        this->setItemShortcutColor(Qt::gray);
        break;
    default: break;
    }
}
