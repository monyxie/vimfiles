set encoding=utf8
set fileencodings=utf8,cp936,latin1
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
lang messages zh_CH.UTF-8

set guifont=ProggyTinyBP:h7
set number
set shiftwidth=4
set cindent
set smartindent
set wrap
set columns=128
set lines=48
set hlsearch
set cursorline
set tabstop=4
set smarttab
set shiftround
set expandtab
set autoindent
set fileformats=dos,unix
set nobackup
color molokaini
set diffopt=filler,vertical

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"php and python execution
"au FileType php map <F5> :call DebugRun('php')<cr>
"au FileType php imap <F5> <Esc>:call DebugRun('php')<cr>
au FileType python map <F5> :call DebugRun('python')<cr>
au FileType python imap <F5> <Esc>:call DebugRun('python')<cr>
function DebugRun(cmd)
    :w
    execute '!' . a:cmd . ' %'
endfunction

"IndentGuides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

"nerdtree
map <F1> :tabp<CR>
map <F2> :tabn<CR>
map <F3> :NERDTreeToggle<CR>

nmap <Space> 15j
nmap <S-Space> 15k

"
"vmap {} s{<Esc>pa}<Esc>
"vmap [] s[<Esc>pa]<Esc>
"vmap () s(<Esc>pa)<Esc>
"vmap <> s<<Esc>pa><Esc>
"vmap "" s"<Esc>pa"<Esc>
"vmap '' s'<Esc>pa'<Esc>
nmap d' vi'dhPl2x<Esc>
nmap d" vi"dhPl2x<Esc>

"custom title
function MyTitleLine()
    let line =  "[" . v:servername . "]%m" . expand("%:t") . " - " . expand("%:h") . " - VIM"
    return line
endfunction
au BufEnter * let &titlestring = MyTitleLine()
au BufRead  * let &titlestring = MyTitleLine()
au BufWrite * let &titlestring = MyTitleLine()

let g:snips_author = 'Mony Xie'

if &diff && has('win32')
    "maxmize gui window
    "au GUIEnter * simalt ~x | "x on an English Windows version. n on a French one
    "above didn't work sometimes
    set lines=999
    set columns=999
endif

au BufRead *.log :set nowrap | :set number
