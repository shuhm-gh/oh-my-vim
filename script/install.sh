#! /bin/bash

source init-fc25-var.sh

install_font()
{
    mkdir -p $_USER_HOME/.local/share/fonts
    cp $PKG_DIR/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf $_USER_HOME/.local/share/fonts
    fc-cache -vf $_USER_HOME/.local/share/fonts/
}

install_md_intant()
{
    npm -g install instant-markdown-d
}

install_vim()
{
    # install nerd font
    install_font
    # install md instant
    install_md_intant

    # npm -g install instant-markdown-d # for suan/vim-instant-markdown
	dnf_install lua-devel python-devel python3-devel tcl-devel ruby-devel ncurses-devel libXt-devel
	cd $VIMSRC_DIR
	make distclean > $NULL 2>>$LOG_ERR_FILE
	./configure --with-features=huge --enable-fail-if-missing --enable-luainterp=yes --enable-mzschemeinterp --enable-tclinterp=yes --enable-pythoninterp=yes --with-python-config-dir=/usr/lib64/python2.7/config --enable-python3interp=yes --with-python3-config-dir=/usr/lib64/python3.5/config-3.5m --enable-cscope --with-x=yes --prefix=/usr/ --with-compiledby=$_USER > $NULL 2>>$LOG_ERR_FILE
	make clean > $NULL 2>>$LOG_ERR_FILE
	$MAKE_J > $NULL 2>>$LOG_ERR_FILE && make install > $NULL 2>>$LOG_ERR_FILE
	dnf_install clang-devel ctags cscope
	$CDROOT > $NULL
	# .vimrc .vim #
	$CP_R $VIMRC_DIR/.vimrc $VIMRC_DIR/.vim $_USER_HOME
	# clang_complete #
	#$ cat .clang_complete 
	#-include /home/$_USER/DEVBIN/instantclient_12_1/sdk/include/oci.h
	#-I /home/$_USER/DEVBIN/instantclient_12_1/sdk/include
	$CD $VIMSRC_DIR
	make distclean > $NULL 2>>$LOG_ERR_FILE
	make clean > $NULL 2>>$LOG_ERR_FILE
	$CDROOT > $NULL
}

install_vim
