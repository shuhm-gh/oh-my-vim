#! /bin/bash

if [ `id -u` -ne 0 ]; then
    echo "only root can run this script..."
    exit
fi

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
if [ ! -d $VIMSRC_DIR ]; then
    for f in vim-*; do if [ -d $f ]; then TMP_DIR=$f; break; elif [ -f $f ]; then TMP_FILE=$f; fi; done
    if [ -n "$TMP_DIR" ]; then
        ln -s $TMP_DIR vim_src
    elif [ -n "$TMP_FILE" ]; then
        tar zxf $TMP_FILE
        TMP_DIR=`echo $TMP_FILE | sed -n 's/\(.*\).tar.gz/\1/p'`
        ln -s $TMP_DIR vim_src
    else
        echo "no vim src found\nexit..."
        exit
    fi
fi

DATE_TAIL=`date "+%y%m%d"`
LOG_ERR_FILE=log-err-$DATE_TAIL

NULL=/dev/null
#NULL=/dev/stdout

RELCFG="/etc/redhat-release"
if grep "CentOS Linux release 7" $RELCFG > /dev/null; then
    OS="CentOS"
elif grep "Fedora release 27 (Twenty Seven)" $RELCFG > /dev/null; then
    OS="Fedora"
else
    echo -e "this config script is only for Fedora and CentOS...\nexit..."
    exit
fi

if [ $OS = "Fedora" ]; then
    INSTALL="dnf install -y"
    PY3_CONF_PATH="/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu/"
else
    INSTALL="yum install -y"
    PY3_CONF_PATH="/usr/lib64/python3.4/config-3.4m"
fi

function dnf_install {
    for i in $*; do
        echo `date "+%Y-%m-%d %H:%M:%S"` $INSTALL $i
        sudo $INSTALL $i > /dev/null 2>&1
        #sudo $INSTALL $i
    done
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
    dnf_install git gcc

    if [ $OS = "CentOS" ]; then
        # 安装依赖, python34-devel是epel仓库中的包
        #dnf_install python-devel
        dnf_install python34-devel
        dnf_install python34-pip
    else
        #dnf install -y python-devel
        dnf_install python3-devel
    fi
    # 安装依赖, python34-devel是epel仓库中的包
    dnf_install lua-devel tcl-devel ruby-devel ncurses-devel libXt-devel

    #
    dnf_install clang-devel ctags cscope
    if [ -f /usr/lib64/llvm/libclang.so ]; then
        ln -sf /usr/lib64/llvm/libclang.so /usr/lib64/libclang.so
    fi

    #git clone https://github.com/vim/vim.git $VIMSRC_DIR

    cd $VIMSRC_DIR

    make distclean > $NULL 2>>$LOG_ERR_FILE
    make clean > $NULL 2>>$LOG_ERR_FILE

    # --enable-pythoninterp=yes --with-python-config-dir=/usr/lib64/python2.7/config
    PARAM_CONF="
        --with-features=huge \
        --enable-fail-if-missing \
        --enable-luainterp=yes \
        --enable-mzschemeinterp \
        --enable-tclinterp=yes \
        --enable-python3interp=yes \
        --with-python3-config-dir=$PY3_CONF_PATH \
        --enable-cscope \
        --with-x=yes \
        --prefix=/usr/ \
        --with-compiledby=$_USER"
    echo $PARAM_CONF
    #NULL=/dev/stdout
    ./configure $PARAM_CONF > $NULL 2>>$LOG_ERR_FILE

    make -j $((`nproc`*2)) > $NULL 2>>$LOG_ERR_FILE && make install > $NULL 2>>$LOG_ERR_FILE

    make distclean > $NULL 2>>$LOG_ERR_FILE
    make clean > $NULL 2>>$LOG_ERR_FILE

    #exit
    cd $VIMROOT > $NULL

    rm -rf $VIMSRC_DIR > $NULL 2>>$LOG_ERR_FILE

    git clone https://github.com/VundleVim/Vundle.vim.git $_USER_HOME/.vim/bundle/Vundle.vim
    chown -R $_USER:$_USER $_USER_HOME/.vim

    # install nerd font
    install_font
    # install md instant
    #install_md_intant

    pip3 install jedi flake8 autopep8
    ln -s /usr/bin/flake8-3 /usr/bin/flake8
    ln -s /usr/bin/python3-autopep8 /usr/bin/autopep8

    cp _vimrc $_USER_HOME/.vimrc
    chown -R $_USER:$_USER $_USER_HOME/.vimrc

    # 安装插件
    #vim -u $_USER_HOME/.vimrc +PluginInstall +qall && sed -i 's/"\(colorscheme solarized\)/\1/' $_USER_HOME/.vimrc
}

install_vim
