# oh-my-vim

### 安装配置 oh-my-vim
* `sudo ./install [user]`
* 修改终端字体 `gnome-terminal -> Edit -> Profile Preferences -> General -> Text Appearance -> Custom font -> DroidSansMonoForPowerline Nerd Font Book 12`
>
> 如想安装指定版本的 vim<br>
> 注释掉 install.sh 脚本 install_vim 函数中 `git clone https://github.com/vim/vim.git $VIMSRC_DIR` 行<br>
> 并自行下载 vim 源代码放到 vim_src 目录(vim_src 目录需自行创建)<br>
> 运行`sudo ./install [user]`

### install.sh 说明
##### 安装编译 vim 源代码所需依赖
```
dnf install -y lua-devel python-devel python3-devel tcl-devel ruby-devel ncurses-devel libXt-devel
```

##### 编译 vim 源代码
下载 vim 源代码放放到目录 vim_src/
```
./configure --with-features=huge --enable-fail-if-missing --enable-luainterp=yes --enable-mzschemeinterp --enable-tclinterp=yes --enable-pythoninterp=yes --with-python-config-dir=/usr/lib64/python2.7/config --enable-python3interp=yes --with-python3-config-dir=/usr/lib64/python3.5/config-3.5m --enable-cscope --with-x=yes --prefix=/usr/ --with-compiledby=$_USER

make && make install
```

##### 安装字体
插件 vim-devicons 和 vim-airline 依赖于本字体
```
mkdir -p $_USER_HOME/.local/share/fonts
cp $VIMROOT/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf $_USER_HOME/.local/share/fonts
fc-cache -vf $_USER_HOME/.local/share/fonts/
```

##### 安装重要插件所需依赖
vim-instant-markdown 依赖:
```
npm -g install instant-markdown-d
```
clang_complete 依赖:
```
dnf install -y clang-devel
```
jedi-vim 依赖:
```
dnf install -y python3-jedi
```
tagbar, 各种跳转功能插件依赖:
```
dnf install -y ctags cscope
```

##### 配置 vim
```
cp _vimrc $_USER_HOME/.vimrc
```

##### 安装插件
```
vim +PluginInstall +qall
```
