#include <QDebug>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlEngine>
#include <QQmlContext>
#include <QColor>
#include <QDBusConnection>
#include <QGuiApplication>

#include "menu_object.h"

MenuObject::MenuObject(QObject *parent) :
    QObject(parent)
{
    menu = new QQuickView();
}

MenuObject::~MenuObject()
{
    if(menu) delete menu;
}

void MenuObject::SetItemActivity(const QString &itemId, bool isActive)
{
    qDebug() << "SetItemActivity";
}

void MenuObject::SetItemChecked(const QString &itemId, bool checked)
{
    qDebug() << "SetItemChecked";
}

void MenuObject::SetItemText(const QString &itemId, const QString &text)
{
    qDebug() << "SetItemText";
}

void MenuObject::ShowMenu(const QString &menuJsonContent)
{
    menu->setFlags(Qt::Tool | Qt::BypassWindowManagerHint);
    menu->setResizeMode(QQuickView::SizeViewToRootObject);
    menu->setColor(QColor(0, 0, 0, 0));
    menu->setSource(QUrl(QStringLiteral("qrc:///FullscreenBackground.qml")));
    menu->show();
    menu->requestActivate();

    QVariant x = 1200;
    QVariant y = 300;
    QVariant content = "";
    QMetaObject::invokeMethod(menu->rootObject(), "showMenu",
            Q_ARG(QVariant, x), Q_ARG(QVariant, y), Q_ARG(QVariant, content));

    QQmlEngine *engine = menu->rootContext()->engine();
    QObject::connect(engine, SIGNAL(quit()), QGuiApplication::instance(), SLOT(quit()));
}
