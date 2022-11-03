execute pathogen#infect()
syntax on
filetype plugin indent on

" Modeline
set modeline

" Reform search.
set ignorecase
set smartcase

" Avoid the leader pinky-stretch.
let mapleader = ","
let maplocalleader = ","

" Visually indicate when we're in insert mode.
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

" No tabs!
set tabstop=2
set shiftwidth=2
set expandtab

" Backups
set nobackup
set noswapfile

" Nerd tree
nmap <LocalLeader>nt :NERDTreeToggle<CR>
nmap <LocalLeader>f :NERDTreeFind<CR>

" Nerd tree tabs - open only if directory was given as a startup argument
let g:nerdtree_tabs_open_on_console_startup=2

" Colours
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" Keep status line visible, as we're using Airline.
set laststatus=2

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" Paredit
let g:paredit_mode = 1

" Rainbow parens
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" Surround
nmap <LocalLeader>w" ysiw"
nmap <LocalLeader>w' ysiw'
nmap <LocalLeader>w( ysiw)
nmap <LocalLeader>w[ ysiw]
nmap <LocalLeader>w{ ysiw}

let g:go_fmt_autosave = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
