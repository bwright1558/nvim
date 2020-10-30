call plug#begin('~/.config/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

syntax on                               " Enables syntax highlighting
filetype plugin indent on               " Enable plugin and indent files
set backspace=indent,eol,start          " Fix backspace in insert mode
set hidden                              " Required to keep multiple buffers open
set nowrap                              " Display long lines as just one line
set ruler                               " Show the cursor position all the time
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set ts=4 sts=4 sw=4 et                  " Make tabs be 4 spaces and convert tab characters to spaces
set smarttab                            " Makes tabbing smarter
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set number                              " Show line numbers
set relativenumber                      " Use relative numbers
set noswapfile                          " Don't create a swap file
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|
set updatetime=300                      " Faster completion
set timeoutlen=1000                     " Shorter time between mapped sequences (default is 1000 ms)A
set clipboard=unnamed                   " Copy/paste between vim and everything else
set incsearch                           " Enable incremental search
set hlsearch                            " Enable search highlighting
set ignorecase                          " Case insensitive search
set smartcase                           " Make search case sensitive when uppercase characters are used
set undodir=~/.undodir                  " Directory to store undo history
set undofile                            " Enable undo history
set scrolloff=8                         " Keep cursor 8 lines from edges when scrolling
set nomodeline                          " Disable set commands in files
set fileformats=unix,dos,mac            " Set EOL formats
set noerrorbells                        " Disable error bells
set colorcolumn=89                      " Show column at 89 characters

" Set leader key to <Space>
nnoremap <Space> <Nop>
let mapleader = ' '

" colorscheme with true colors enabled
set termguicolors
set background=dark
colorscheme onedark

" airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1

" fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>

" vim-commentary
nnoremap <Leader>/ :Commentary<CR>
vnoremap <Leader>/ :Commentary<CR>

" vim-signify
let g:signify_sign_show_count = 0
nmap <Leader>gj <Plug>(signify-next-hunk)
nmap <Leader>gk <Plug>(signify-prev-hunk)
nmap <Leader>gJ 9999<Leader>gj
nmap <Leader>gK 9999<Leader>gk

" Coc extensions
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-explorer',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-rls',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-yaml',
  \ 'coc-yank',
  \ ]

" Format document
command! -nargs=0 Format :call CocAction('format')

nnoremap <silent> <Leader>y :<C-u>CocList -A --normal yank<CR>

nmap <silent> <Leader>e :exe 'CocCommand explorer ' . getcwd()<CR>

augroup CocExplorerHijackNetrw
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,VimEnter * let d = expand('<amatch>') | if isdirectory(d) | exe 'cd ' . d | bd | exe 'CocCommand explorer ' . d | endif
augroup END

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent> <expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <CR> to confirm completion, <C-g>u means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <CR> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Coc rename
nmap <Leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Stop newline continuation of comments
autocmd FileType * setlocal formatoptions-=cro

" Copy/paste for OSX
if has('macunix')
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Trim trailing whitespace and newlines at EOF on save
command! -nargs=0 TrimWhitespace :%s/\s\+$//e
command! -nargs=0 TrimNewlines :%s/\($\n\s*\)\+\%$//e
autocmd BufWritePre * exe 'TrimWhitespace' | exe 'TrimNewlines'

" Retain visual selection when indenting lines
vnoremap > >gv
vnoremap < <gv

" Switch between buffers using tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Move selected lines of text in visual mode
" shift + k to move up
" shift + j to move down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Better omnicomplete navigation
inoremap <expr> <C-j> "\<C-n>"
inoremap <expr> <C-k> "\<C-p>"

tnoremap <C-\> <C-\><C-n>

" Stop highlighting for hlsearch
nnoremap <silent> <Leader>n :noh<CR>

" make/cmake
autocmd FileType make setlocal noet

" python
let g:python_highlight_all = 1

" go
autocmd FileType go setlocal noet
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_imports_autosave = 1

" javascript/react
autocmd FileType javascript,javascriptreact setlocal ts=2 sts=2 sw=2 et

" typescript
autocmd FileType typescript setlocal ts=2 sts=2 sw=2 et

" json
autocmd FileType json setlocal ts=2 sts=2 sw=2 et

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et

" graphql
autocmd FileType graphql setlocal ts=2 sts=2 sw=2 et

" html
autocmd FileType html setlocal ts=2 sts=2 sw=2 et

" css
autocmd FileType css,scss setlocal ts=2 sts=2 sw=2 et

" markdown
autocmd FileType markdown setlocal ts=2 sts=2 sw=2 et
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" vim
autocmd FileType vim setlocal ts=2 sts=2 sw=2 et

" zsh
autocmd FileType zsh setlocal ts=2 sts=2 sw=2 et
