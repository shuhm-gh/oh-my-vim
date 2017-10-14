set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

Plugin 'ervandew/supertab'
Plugin 'ronakg/quickr-cscope.vim'
Plugin 'Rip-Rip/clang_complete'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'davidhalter/jedi-vim'

"Plugin 'moll/vim-node'
Plugin 'pangloss/vim-javascript'
Plugin 'walm/jshint.vim'
Plugin 'ternjs/tern_for_vim'

Plugin 'plasticboy/vim-markdown'
"Plugin 'suan/vim-instant-markdown'

"Plugin 'jiangmiao/auto-pairs'

"autocmd FileType python,shell set commentstring=#\ %s
"autocmd FileType mako set cms=##\ %s
"gc, gcu
Plugin 'tpope/vim-commentary'

"ysiw, cs, ds
Plugin 'tpope/vim-surround'

"text filtering and alignment; :Tab /= :Tab /:
Plugin 'godlygeek/tabular'

"c-n c-n c xxx <esc>
Plugin 'terryma/vim-multiple-cursors'

Plugin 'vim-syntastic/syntastic'

Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'

Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'

Plugin 'gko/vim-coloresque'

Plugin 'will133/vim-dirdiff'
Plugin 'mileszs/ack.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
"Plugin 'tmhedberg/SimpylFold'
Plugin 'nvie/vim-flake8'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'tell-k/vim-autopep8'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:pymode_python = 'python3'
"autocmd FileType python python3 sys.path.append('.')
autocmd VimEnter *.py python3 sys.path.append('.')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread "自动加载 手动加载 :e!

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=3

" Turn on the WiLd menu
" 命令行补全函数
set wildmenu

" Ignore compiled files
" tab键的自动完成现在会忽略
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
"indent: 如果用了:set indent,:set ai等自动缩进，想用退格键将字段缩进的删掉，必须设置这个选项。否则不响应。
"eol:如果插入模式下在行开头，想通过退格键合并两行，需要设置eol。
"start：要想删除此次插入前的输入，需设置这个。
set backspace=eol,start,indent "处理Backspace各种不能用
" 缺省情况下，h和l命令不会把光标移出当前行。如果已经到了行首，无论按多少次h键，光标始终停留在行首，l命令也类似。如果希望h和l命令可以移出当前行
set whichwrap+=<,>,h,l

" enable matchit
runtime macros/matchit.vim

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
"syntax on

"colorscheme desert
"set background=dark

"colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1

set background=dark
"set t_Co=256 
let g:solarized_termcolors=256
"colorscheme solarized
"call togglebg#map("<F5>")

"autocmd VimEnter * ToggleBG

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces, python编码时还是4, 可能是python插件的行为
set tabstop=4
set softtabstop=4
set shiftwidth=4 "C/C++换行时的缩进

"set autoindent
set textwidth=79

"autocmd FileType python set tabstop=4 | set expandtab | set autoindent
"autocmd FileType python call Flake8()
autocmd BufWritePost *.py call Flake8()

"au BufNewFile,BufRead *.py
"\ set tabstop=4
"\ set softtabstop=4
"\ set shiftwidth=4
"\ set textwidth=79
"\ set expandtab
"\ set autoindent
"\ set fileformat=unix

" 多余的空格
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Linebreak on 500 characters
set lbr
set tw=500

"smartindent 使 python 中 # 自动回退到行首
set ai "Auto indent
"set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"map <C-c> <C-w>c
nnoremap <C-c> <C-w>c
imap jj <ESC>

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

"gp粘贴并且移动光标到粘贴内容后
nmap <leader>v "+gp
imap <c-v> <esc>"+gp
nmap <leader>c "+yiw
vmap <leader>c "+y
"nmap <S-C-c> "+yiw "可能是因为与系统快捷键冲突，不可行 nmap, nnoremap均不可行
"nmap <S-C-v> "+p

" Specify the behavior when switching between buffers 
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
set statusline+=%{fugitive#statusline()}

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Pos(%4l,%4c)

"airline
"let g:airline_theme="luna"
"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"设置切换Buffer快捷键"
nnoremap <C-TAB> :bn<CR>
nnoremap <C-s-TAB> :bp<CR>

" 设置为double导致NERDTree可能无法对齐
"set ambiwidth=double

" step 2: font configuration
" These are the basic settings to get the font to work (required):
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set encoding=utf-8
" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
"map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
"function! HasPaste()
"    if &paste
"        return 'PASTE MODE  '
"    en
"    return ''
"endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

"""

autocmd FileType java setlocal omnifunc=javacomplete#Complete

set nocompatible
"set completeopt=longest,menu
" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>" 
autocmd FileType java let g:SuperTabDefaultCompletionType = "<c-x><c-o>" 
"set completeopt-=preview 

"autocmd FileType python imap <TAB> <C-Space>
"autocmd FileType python set omnifunc=pythoncomplete#Complete

"build python to find errors
"autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
"autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line%l%.%#,%Z%[%^\ ]%\\@=%m

"set autowriteall "自动保存

" automatically reload vimrc when it's saved
"au BufWritePost .vimrc so ~/.vimrc

set fileencodings=utf-8,ucs-bom,cp936,big5 "解决打开gbk编码文件乱码问题
"set paste "导致jedi-vim <C-Space>, <c-v>, jj, insert模式下的快捷键都用不了
"noremap <Leader>p :set paste<CR>
"noremap <Leader>P :set nopaste<CR>

set guifont=Monospace\ 16 "guifont = Courier\ New\ 12, Arial\ 10
set list
set listchars=tab:.\ 
set nu
map <silent> <leader>1 :set nu<cr>
map <silent> <leader>2 :set nonu<cr>

"set cul cuc

" SuperTab option for context aware completion
"let g:SuperTabDefaultCompletionType = "context"
autocmd FileType c,cpp,cc,h,hpp let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
"autocmd FileType python let g:SuperTabDefaultCompletionType = "<C-Space>"

cabbrev copen bot copen

"
" .clang_complete
" -I-std=c++0x
" -I/usr/include/QtGui/
" -I/usr/include/QtCore/
" -I.
" Disable auto popup, use <Tab> to autocomplete
let g:clang_complete_auto = 0
" Show clang errors in the quickfix window
let g:clang_complete_copen = 1
" if there's an error, allow us to see it
let g:clang_complete_copen=1
let g:clang_complete_macros=1
let g:clang_complete_patterns=0
" Limit memory use
let g:clang_memory_percent=70
" Remove -std=c++11 if you don't use C++ for everything like I do.
let g:clang_user_options=' -std=c++11 || exit 0'
"let g:clang_user_options=' -std=c++11 || exit 0'
"let g:clang_user_options='-stdlib=libc++ -std=c++11 -IIncludePath'

" Set this to 0 if you don't want autoselect, 1 if you want autohighlight,
" and 2 if you want autoselect. 0 will make you arrow down to select the first
" option, 1 will select the first option for you, but won't insert it unless you
" press enter. 2 will automatically insert what it thinks is right. 1 is the most
" convenient IMO, and it defaults to 0.
let g:clang_auto_select=1

set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
" The single one that works with clang_complete
let g:clang_snippets_engine='clang_complete'

let g:clang_periodic_quickfix=0
let g:clang_close_preview=1
let g:clang_use_library=1
"let g:clang_library_path='/usr/lib64/llvm/libclang.so'
let g:clang_library_path='/usr/lib64/libclang.so'
"let g:clang_library_path='/usr/lib64'

" js
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1

let jshint2_command = '~/path/to/node_modules/.bin/jshint'

" markdown
let g:vim_markdown_folding_disabled = 1

" tagbar

"设置tagbar使用的ctags的插件,必须要设置对  
let g:tagbar_ctags_bin='/usr/bin/ctags'  
"设置tagbar的窗口宽度  
let g:tagbar_width=30  
"设置tagbar的窗口显示的位置,为左边  
"let g:tagbar_left=1  
"打开文件自动 打开tagbar  
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.js,*.py call tagbar#autoopen()  
"映射tagbar的快捷键  
"map <F8> :TagbarToggle<CR> 

"
"" taglist
"
"let Tlist_Auto_Open=1
"let Tlist_Show_One_File=1    "只显示当前文件的tags
"let Tlist_WinWidth=30        "设置taglist宽度
""let Tlist_WinHeight
"let Tlist_Exit_OnlyWindow=1  "tagList窗口是最后一个窗口，则退出Vim
"let Tlist_Use_Right_Window=1 "在Vim窗口右侧显示taglist窗口
"autocmd BufWritePost *.c,*.cpp,*.py :TlistUpdate

"let g:quickr_cscope_keymaps = 0
"let g:quickr_cscope_autoload_db = 0

"set tags+=$HOME/.vim/tags/python.ctags
"nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
"nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
"nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
"nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>

"nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"if has("cscope")
"    set csprg=/usr/bin/cscope
"    "set cscopequickfix=s+,c+,d+,i+,t+,e+
"    "set cscopequickfix=s-,c-,d-,i-,t-,e-
"    "set cscopequickfix=s-!,c-,d!-,t+!,e-
"    set csto=0
"    set cst
"    set nocsverb
"    " add any database in current directory
"    if filereadable("cscope.out")
"        cs add cscope.out
"        " else add database pointed to by environment
"    elseif $CSCOPE_DB != ""
"        cs add $CSCOPE_DB
"    endif
"    set csverb
"endif

"
"
"
"let NERDTreeWinPos='right'
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.bak$', '\.a$']
map <C-S-r> :NERDTreeMirror<CR> "F3
map <C-S-r> :NERDTreeToggle<CR>
"autocmd BufRead * NERDTree "Ctrl-P
"打开文件后会自动激活NERDTree窗口，很不方便，每次都要进行窗口切换
"autocmd VimEnter * NERDTree

let g:autopep8_aggressive=2

"using flake8 as a python syntax checker 
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E225'

let g:jedi#force_py_version=3
let g:jedi#smart_auto_mappings = 0
"let g:jedi#completions_enabled = 0
"let g:pydiction_location='$HOME/.vim/complete-dict'

"let g:SimpylFold_docstring_preview=1

"command -nargs=* R cexpr system('<args>') | copen
"E183: User defined commands must start with an uppercase letter
"map <C-F11> :R python bufname("%")<cr>
"map <C-F11> :!python %<cr>
"autocmd FileType python let b:dispatch = 'python %'
"nnoremap <C-F11> :Dispatch<CR>

"""

"_vimrc for win32
"set fileformat=unix
"set encoding=utf-8 "解决utf-8编码文件乱码问题
"set fileencodings=utf-8,ucs-bom,cp936,big5
"set fileencoding=utf-8 "保存为utf-8编码
"set termencoding=&encoding

"language messages zh_CN.utf-8
"解决提示（如启动时提示语，左下角的"插入"）乱码问题

"Gvim没有任何问题, vim输入中文时显示乱码
