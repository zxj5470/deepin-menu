import QtQuick 2.0

ListView {
    id: listview
    focus: true                 /* to enable key navigation */
    currentIndex: -1
    model: MenuItemListModel { menuItems: listview.menuItems}
    delegate: MenuItemDelegate {}
    /* keyNavigationWraps: true */
    /* interactive: false */

    property var fullscreenBg: null
    property int textSize: 12
    property int textLeftMargin: 22
    property int textRightMargin: 22
    property int horizontalPadding: 3
    property int verticalPadding: 3
    property int pictureSize: 16
    property int minWidth: 100

    property string arrowDark: "images/arrow-dark.png"
    property string arrowDarkHover: "images/arrow-dark-hover.png"
    property string arrowLight: "images/arrow-light.png"
    property string arrowLightHover: "images/arrow-light-hover.png"

    property color textColor: Qt.rgba(1, 1, 1, 1)

    property string menuItems: ""

    property bool isDockMenu: false

    /* below two property is created for onCurrentItemChanged method. */
    property int lastCurrentIndex: 0
    property var lastCurrentItem: null
    onCurrentItemChanged: {
        /* console.log(currentItem.isSep) */
        if (currentItem.isSep) {
            if (currentIndex > lastCurrentIndex) {
                currentIndex += 1
            }
            if (currentIndex < lastCurrentIndex) {
                currentIndex -= 1
            }
            lastCurrentIndex = currentIndex
        }

        if (isDockMenu) {
            /* clear selection effect */
            if (lastCurrentItem != null) {
                lastCurrentItem.itemTextColor = textColor
				lastCurrentItem.itemArrowPic = listview.arrowDark
            }

            /* selection effect */
            if (currentItem != null) {
                currentItem.itemTextColor = "#00A4E2"
				currentItem.itemArrowPic = listview.arrowDarkHover
            }
        } else {
            /* clear selection effect */
            if (lastCurrentItem != null) {
				lastCurrentItem.itemArrowPic = listview.arrowLight
            }

            /* selection effect */
            if (currentItem != null) {
				currentItem.itemArrowPic = listview.arrowLightHover									
            }

        }
        lastCurrentItem = currentItem

        // Destroy old subMenu
        if (menu.subMenuObj != null) {
            menu.subMenuObj.destroy(10)
            menu.subMenuObj = null
        }

        // Create new subMenu
        if (currentItem.componentSubMenu != "[]") {
            if (currentItem.componentSubMenu != null) {
                var component = Qt.createComponent("RectMenu.qml");
                var component_menuItems = currentItem.componentSubMenu

                var component_size = currentItem.ListView.view.getSize(component_menuItems)
                var component_width = component_size.width
                var component_height = component_size.height

                var component_x = menu.x + menu.width - menu.blurWidth * 2
                var component_y = menu.y + currentItem.y

                if (component_x + component_width> fullscreen_bg.width) {
                    component_x = menu.x - component_width
                }

                if (component_y + component_height > fullscreen_bg.height) {
                    component_y = fullscreen_bg.height - component_height
                }

                var obj = component.createObject(fullscreen_bg, {"x": component_x, "y": component_y,
                                                                 "borderColor": menu.borderColor,
                                                                 "blurWidth": menu.blurWidth,
                                                                 "fillColor": menu.fillColor, "fontColor": menu.fontColor,
                                                                 "isDockMenu": menu.isDockMenu,
                                                                 "menuItems": component_menuItems, "fullscreenBg": fullscreenBg});
                menu.subMenuObj = obj
            }
        }
    }

    function getSize(menuItems) {
        var items = JSON.parse(menuItems)
        var _width = 0
        var _height = 0
        for (var i in items) {
            if (_injection.getStringWidth(items[i].itemText, textSize)
                + textLeftMargin + textRightMargin + horizontalPadding > _width) {
                _width = _injection.getStringWidth(items[i].itemText, textSize)
                + textLeftMargin + textRightMargin + horizontalPadding
            }

            if (items[i].itemText == undefined || items[i].itemText == "") {
                _height += verticalPadding * 2 + 2
            } else {
                _height += Math.max(_injection.getStringHeight(items[i].itemText, textSize) + verticalPadding * 2,
                                    pictureSize + verticalPadding * 2)
            }
        }

        return {"width": _width, "height": _height}
    }

    Component.onCompleted: {
        var size = getSize(menuItems)

        listview.width = (Math.max(size.width, minWidth))
        listview.height = size.height

        if (!isDockMenu) {
            var component = Qt.createComponent("MenuSelection.qml");
            highlight = component.createObject(listview, {})
        }
    }
}
