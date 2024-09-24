#!/bin/bash

echo "check_root_permission"
SUDO=
if [ "$UID" != "0" ]; then
	if [ -e /usr/bin/sudo -o -e /bin/sudo ]; then
		SUDO=sudo
	else
		echo "需要 Root 權限來安裝依賴套件"
		exit 0
	fi
fi

install_basic_package(){
	$SUDO apt install -y \
		build-essential \
		checkinstall \
		git \
		autoconf \
		automake \
		libtool-bin \
		doxygen \
		libplist-dev \
		pkg-config \
		libimobiledevice-dev \
		clang \
		libusbmuxd-dev \
  		libcurl4-openssl-dev \
		libusb-1.0-0-dev \
		libavahi-compat-libdnssd-dev \
		python3-pip > /dev/null 2>&1

	$SUDO pip3 install cython --break-system-packages > /dev/null 2>&1
}	

pull_git_repo(){
	cd $HOME/libimobile-dependencies
	git clone https://github.com/libimobiledevice/libplist.git > /dev/null 2>&1
	git clone https://github.com/libimobiledevice/libimobiledevice-glue.git > /dev/null 2>&1
	git clone https://github.com/libimobiledevice/libusbmuxd.git > /dev/null 2>&1
	git clone https://github.com/libimobiledevice/libtatsu.git > /dev/null 2>&1
	git clone https://github.com/libimobiledevice/libimobiledevice.git > /dev/null 2>&1
	git clone https://github.com/tihmstar/usbmuxd2.git > /dev/null 2>&1
	git clone https://github.com/tihmstar/libgeneral.git > /dev/null 2>&1
}

compile_libplist(){
	cd "$HOME/libimobile-dependencies/libplist"
	./autogen.sh > /dev/null 2>&1
	make > /dev/null 2>&1
	$SUDO make install > /dev/null 2>&1
}

compile_libimobiledevice_glue(){
	cd "$HOME/libimobile-dependencies/libimobiledevice-glue"
	./autogen.sh > /dev/null 2>&1
	make > /dev/null 2>&1
	$SUDO make install > /dev/null 2>&1
}

compile_libusbmuxd(){
	cd "$HOME/libimobile-dependencies/libusbmuxd"
	./autogen.sh > /dev/null 2>&1
	make > /dev/null 2>&1
	$SUDO make install > /dev/null 2>&1
}

compile_libtatsu(){
	cd "$HOME/libimobile-dependencies/libtatsu"
	./autogen.sh > /dev/null 2>&1
	make > /dev/null 2>&1
	$SUDO make install > /dev/null 2>&1
}

compile_libimobiledevice(){
	cd "$HOME/libimobile-dependencies/libimobiledevice"
	./autogen.sh > /dev/null 2>&1
	make > /dev/null 2>&1
	$SUDO make install > /dev/null 2>&1
}

compile_usbmuxd2(){
	cd "$HOME/libimobile-dependencies/libgeneral"
	./autogen.sh > /dev/null 2>&1
	make > /dev/null 2>&1
	$SUDO make install > /dev/null 2>&1

	cd "$HOME/libimobile-dependencies/usbmuxd2"
	./configure CC=clang CXX=clang++ > /dev/null 2>&1
	make > /dev/null 2>&1
	$SUDO make install > /dev/null 2>&1
}

mkdir -p "$HOME/libimobile-dependencies"
echo "Installing deb and python packages"
install_basic_package

echo "Pulling git repos"
pull_git_repo

if which plistutil > /dev/null 2>&1; then
	echo "libplist is already installed"
else
	echo "installing libplist"
	compile_libplist
fi

echo "installing libimobiledevice-glue"
compile_libimobiledevice_glue

echo "installing libusbmuxd"
compile_libusbmuxd

echo "installing libtatsu"
compile_libtatsu

echo "installing libimobiledevice"
compile_libimobiledevice

echo "installing usbmuxd2"
compile_usbmuxd2

echo "Done installing. Removing libimobile-dependencies folder"
$SUDO rm -rf "$HOME/libimobile-dependencies"
