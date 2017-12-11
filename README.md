# Deepin Menu

Deepin Menu is the unified menu service for Deepin Desktop Environment.

## Dependencies

### Build dependencies

* qmake (>= 5.3)
* python2
* python2 setup tools
* XCB and XLib
* libdframeworkdbus-dev

### Runtime dependencies

* DBus
* Qt5 (>= 5.3)
  * Qt5-Widgets
  * Qt5-Gui
  * Qt5-DBus
  * Qt5-X11extras

## Installation

### Build from source code

1. Make sure you have installed all dependencies.

2. Build:
```
$ cd deepin-menu
$ mkdir build
$ cd build
$ qmake ..
$ make
```

3. Install:
```
$ sudo make install
```

## Usage

Run the binary, the two DBus interfaces com.deepin.Menu.Manager and com.deepin.Menu it provides should 
be sufficient to explain itself. More details on the data structure it uses needs to be done.

## Getting help

You may also find these channels useful if you encounter any other issues:

* [Gitter](https://gitter.im/orgs/linuxdeepin/rooms)
* [IRC Channel](https://webchat.freenode.net/?channels=deepin)
* [Official Forum](https://bbs.deepin.org/)
* [Wiki](http://wiki.deepin.org/)

## License

Deepin Menu is licensed under [GPLv3](LICENSE).
