# Qt 5.12.7 Compilation and Installation guide
## On desktop (Debian or Ubuntu based)
Easiest way to install is to download and run the online [installer](https://www.qt.io/download-open-source?hsCtaTracking=9f6a2170-a938-42df-a8e2-a9f0b1d6cdce%7C6cb0de4f-9bb5-4778-ab02-bfb62735f3e5) (open source use) 
## On Raspberrypi
This is the difficult part, the following steps are based on these tutorials:
- [https://www.tal.org/tutorials/building-qt-512-raspberry-pi](https://www.tal.org/tutorials/building-qt-512-raspberry-pi) compilation
- [https://mechatronicsblog.com/cross-compile-and-deploy-qt-5-12-for-raspberry-pi/](https://mechatronicsblog.com/cross-compile-and-deploy-qt-5-12-for-raspberry-pi/) setting up remote debugging

On **raspberrypi 3B+** (for a complete explanation see the first link):
1. install dependencies and optional packages:
```
apt-get update
```
```
apt-get install build-essential libfontconfig1-dev libdbus-1-dev libfreetype6-dev libicu-dev libinput-dev libxkbcommon-dev libsqlite3-dev libssl-dev libpng-dev libjpeg-dev libglib2.0-dev libraspberrypi-dev
```
2. From */home/\<user\>/Downloads/*
```
wget http://download.qt.io/official_releases/qt/5.12/5.12.7/single/qt-everywhere-src-5.12.7.tar.xz
```
```
tar xf qt-everywhere-src-5.12.7.tar.xz
```
3. Setup mkspecs configuration files:
```
git clone https://github.com/oniongarlic/qt-raspberrypi-configuration.git
```
```
cd qt-raspberrypi-configuration && make install DESTDIR=../qt-everywhere-src-5.12.7
```
4. configure build environment:
```
cd ..
```
```
mkdir build && cd build
```
```
PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig:/usr/share/pkgconfig \
../qt-everywhere-src-5.12.7/configure -platform linux-rpi3-g++ \
-v \
-opengl es2 -eglfs \
-no-gtk \
-opensource -confirm-license -release \
-reduce-exports \
-force-pkg-config \
-nomake examples -no-compile-examples \
-skip qtwayland \
-skip qtwebengine \
-skip qtscript\
-no-feature-geoservices_mapboxgl \
-qt-pcre \
-no-pch \
-ssl \
-evdev \
-system-freetype \
-fontconfig \
-glib \
-prefix /opt/Qt5.12 \
-qpa eglfs
```
5. make:
```
make -j2
```
6. install if everything went well:
```
sudo make install
```
7. qmake should be in the following path:
```
/opt/Qt5.12/bin/qmake
``` 

---
# qtmqtt library
## On desktop (Debian or Ubuntu based)

1. From */home/\<user\>/Downloads/*
```
git clone -b 5.12.7 https://github.com/qt/qtmqtt.git
```
```
cd qtmqtt-5.12.7
```
```
mkdir build && cd build
```
2. run qmake, make and install (I use the absolute path of qmake, might be useful if you have more than one version installed)
```
/opt/Qt/5.12.7/gcc_64/bin/qmake -r ..
```
```
make -j2
```
```
sudo make install
```
If an error message appears (```QtMqtt/qmqttglobal.h not found error```) copy the .h and .cpp files from ```qtmqtt-5.12.7/src/mqtt/``` to your installation include directory, in my case it is ```/opt/Qt/5.12.7/gcc_64/include/``` where I added the directory ```QtMqtt``` containing these files. Trying again should work (after ```make clean```).


## On Raspberrypi

Same steps as on desktop, just check your qmake path first, for example mine is at ```/opt/Qt5.12/bin/qmake``` and my corresponding include path for the qtmqtt .h and .cpp files is at ```/opt/Qt5.12/include/```