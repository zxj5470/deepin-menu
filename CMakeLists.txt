cmake_minimum_required(VERSION 3.6)
project(deepin-menu)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR TRUE)
set(CMAKE_AUTOMOC TRUE)

find_package(Qt5Widgets)
find_package(Qt5Core)
find_package(Qt5Gui)

# include qt
set(QTPATH /usr/include/x86_64-linux-gnu/qt5)
include_directories(
        ${QTPATH}/QtDBus
        ${QTPATH}/QtX11Extras
)

# include dtk
include_directories(/usr/include/libdtk-2.0/DCore)
include_directories(/usr/include/libdtk-2.0/DWidget)

# include dbus
include_directories(/usr/include/libdframeworkdbus-1.0)

set(deepin_menu_libs
        Qt5::Core
        Qt5::Gui
        Qt5::Widgets
        Qt5DBus
        Qt5X11Extras

        dframeworkdbus
        dtkcore
        dtkwidget
        xcb
        X11
        )

file(GLOB cppsrc "src/*.cpp" "src/*.h")
add_executable(deepin-menu ${cppsrc})
target_link_libraries(deepin-menu ${deepin_menu_libs})

