set nocompatible              " be iMproved, required
let g:mapleader = "\<Space>"

" autoinstall vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Detects indentation.
Plug 'tpope/vim-sleuth'
Plug 'bronson/vim-trailing-whitespace'

Plug 'iCyMind/NeoSolarized'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
  function! s:goyo_enter()
    Limelight
    set spell noci nosi noai nolist noshowmode noshowcmd linebreak
    " let &background = ( &background == "light" ? "dark" : "light" )
    let b:complete = &complete
    set complete+=s
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

    noremap j gj
    noremap k gk
    noremap 0 g0
    noremap $ g$
  endfunction

  function! s:goyo_leave()
    Limelight!
    set nospell ci si ai noshowmode showcmd nolinebreak
    " let &background = ( &background == "light" ? "dark" : "light" )
    let &complete = b:complete
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
        qa!
      else
        qa
      endif
    endif

    unmap j
    unmap k
    unmap 0
    unmap $
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()

  nmap <leader>p :Goyo<CR>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  nmap <silent> <leader><space> :Files<CR>
  nmap <silent> <leader>f :Buffers<CR>
  nmap <silent> <leader>? :History<CR>

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

" Repeat plugin commands (e.g. vim-surround).
Plug 'tpope/vim-repeat'

Plug 'jeffkreeftmeijer/vim-numbertoggle'
  set number relativenumber

Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Rename symbol.
  nmap <leader>rn <Plug>(coc-rename)

  " Format selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ ]

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Make backspace work on indents.
set backspace=indent,eol,start

" 80 character column highlight
if exists('+colorcolumn')
  highlight ColorColumn ctermbg=235
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

set winwidth=82

" Remap split navigation
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" More natural split openings
set splitbelow
set splitright

" Faster escape
inoremap kj <Esc>
inoremap <ESC> <NOP>

" Reload on file write
set autoread

" Buffer around cursor
set scrolloff=6

" Set true colors (NeoVim)
set termguicolors

" Turn on syntax highlighting
set background=dark
colorscheme NeoSolarized

" Airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1

" Enable powerline symbols
set encoding=utf-8

" Mouse mode!
set mouse=a
