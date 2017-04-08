#! /bin/bash

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

ROOT=`realpath $0`
ROOT=${ROOT%/*}

VIMROOT=$ROOT
VIMSRC_DIR=$ROOT/vim_src

DATE_TAIL=`date "+%y%m%d"`
LOG_ERR_FILE=log-err-$DATE_TAIL

NULL=/dev/null
#NULL=/dev/stdout

check_root()
{
    if [ `id -u` -ne 0 ]; then
        echo "only root can run this script..."
        exit
    fi
}

check_os()
{
    RELCFG="/etc/redhat-release"
    if ! grep "Fedora release 25" $RELCFG > /dev/null; then
        echo -e "this config script is only for Fedora release 25 (Twenty Five)\nexit..."
        exit
    fi
}

install_font()
{
    mkdir -p $_USER_HOME/.local/share/fonts
    cp $VIMROOT/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf $_USER_HOME/.local/share/fonts
    fc-cache -vf $_USER_HOME/.local/share/fonts/
}

install_md_intant()
{
    npm -g install instant-markdown-d
}

install_vim()
{
    # 安装依赖
    dnf install -y lua-devel python-devel python3-devel tcl-devel ruby-devel ncurses-devel libXt-devel

    git clone https://github.com/vim/vim.git $VIMSRC_DIR

    cd $VIMSRC_DIR

    make distclean > $NULL 2>>$LOG_ERR_FILE
    make clean > $NULL 2>>$LOG_ERR_FILE

    ./configure --with-features=huge --enable-fail-if-missing --enable-luainterp=yes --enable-mzschemeinterp --enable-tclinterp=yes --enable-pythoninterp=yes --with-python-config-dir=/usr/lib64/python2.7/config --enable-python3interp=yes --with-python3-config-dir=/usr/lib64/python3.5/config-3.5m --enable-cscope --with-x=yes --prefix=/usr/ --with-compiledby=$_USER > $NULL 2>>$LOG_ERR_FILE

    make -j $((`nproc`*2)) > $NULL 2>>$LOG_ERR_FILE && make install > $NULL 2>>$LOG_ERR_FILE

    make distclean > $NULL 2>>$LOG_ERR_FILE
    make clean > $NULL 2>>$LOG_ERR_FILE

    cd $VIMROOT > $NULL

    git clone https://github.com/VundleVim/Vundle.vim.git $_USER_HOME/.vim/bundle/Vundle.vim

    # install nerd font
    install_font
    # install md instant
    install_md_intant

    dnf install -y clang-devel ctags cscope python3-jedi


    cp _vimrc $_USER_HOME/.vimrc
}

check_root
check_os
install_vim
