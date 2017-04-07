#! /bin/bash

echo "include +++++ `realpath $0` +++++"

INIT_ROOT=`realpath $0`
INIT_ROOT=${INIT_ROOT%/*}
PKG_DIR=${INIT_ROOT}/../pkg
BIN_DIR=${INIT_ROOT}/../bin
CFG_DIR=${INIT_ROOT}/../conf
_USER=""
_USER_HOME=""

DIR_MK="rm s bin devbin" # important

DATE_TAIL=`date "+%y%m%d"`
LOG_ERR_FILE=log-err-$DATE_TAIL

NULL=/dev/null
#NULL=/dev/stdout

export INIT_ROOT

INSTALL="dnf install -y"
INSTRPM="rpm -ivh"
CP_R="cp -r"
RM_RF="rm -rf"
CD="cd"
CDROOT="cd $INIT_ROOT"

DL="wget"

parallel=$((`nproc`*2))
MAKE_J="make -j$parallel"

VIM_HOME=$PKG_DIR/vimfiles
VIMSRC_DIR=$VIM_HOME/vim74
VIMRC_DIR=$VIM_HOME/vimrc

LOCKKEYS_DIR=$PKG_DIR/lock-keys

# sudo -> $USER is 'root'
if (($# == 1)); then
	_USER=$1
else
	_USER=kylin
fi

if [ $_USER = "root" ]; then
	_USER_HOME=/$_USER
else
	_USER_HOME=/home/$_USER
fi

BINDIR=$_USER_HOME/bin
DEVBINDIR=$_USER_HOME/devbin

echo "include +++++ `realpath $0` +++++ end"
