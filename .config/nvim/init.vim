" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path


call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jpalardy/vim-slime'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'pixelneo/vim-python-docstring'
call plug#end()

let mapleader = "\\"

"filetype plugin indent on
filetype on
syntax enable

set encoding=utf-8
set hidden
set splitright

" Treat leading zeros as decimal numbers and not octal
set nrformats=

"Recursive path
set path+=**/*

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Statusline
set nu rnu
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" Use same column for numbers and errors
set signcolumn=number

" Ignore case almost always
set ignorecase smartcase

set spelllang=en,es,fr
set incsearch
set wildmenu
		
" Undofile
set undofile

" Colours 
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colorscheme jummidark


" Sudo after opening file
cmap w!! w !sudo tee % >/dev/null

" Use kj as escape 
inoremap <silent> kj <Esc>
xnoremap <silent> kj <Esc>

" Toggle spell checking
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

" Clipboard
set clipboard+=unnamedplus

"" Moving between virtual lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <leader>b :ls<cr>:b<space>

" Open quickfix list
nnoremap <F2> :Copen<CR>
inoremap <F2> :Copen<CR>

" Reload nvim config
nnoremap <silent> <leader>ei :e $MYVIMRC<CR>
nnoremap <Leader>si :source $MYVIMRC<CR>

" Jump over delimiter
inoremap <S-Tab> <esc>la

" Fix the last mistake while typing
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Faster autocompletition
set completeopt+=noinsert
"
inoremap <silent> ,f <C-x><C-f>
inoremap <silent> ,i <C-x><C-i>
inoremap <silent> ,l <C-x><C-l>
inoremap <silent> ,n <C-x><C-n>
inoremap <silent> ,o <C-x><C-o>
inoremap <silent> ,t <C-x><C-]>
inoremap <silent> ,u <C-x><C-u>

let g:tex_flavor = "latex"


" My tiny trick for local vim configuration
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction


call SourceIfExists(".localvim")

" Newtr
"
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 25


" Jedi
"
let g:jedi#completions_command = "<C-N>"

au BufRead,BufNewFile *.tsv setfiletype tsv

" Noevim Terminal
tnoremap kj <C-\><C-n>
inoremap kj <esc>

function s:exec_on_term(lnum1, lnum2)
  " get terminal buffer
  let g:terminal_buffer = get(g:, 'terminal_buffer', -1)
  " open new terminal if it doesn't exist
  if g:terminal_buffer == -1 || !bufexists(g:terminal_buffer)
    terminal
    let g:terminal_buffer = bufnr('')
    wincmd p
  " split a new window if terminal buffer hidden
  elseif bufwinnr(g:terminal_buffer) == -1
    exec 'sbuffer ' . g:terminal_buffer
    wincmd p
  endif
  " join lines with "\<cr>", note the extra "\<cr>" for last line
  " send joined lines to terminal.
  call term_sendkeys(g:terminal_buffer,
        \ join(getline(a:lnum1, a:lnum2), "\<cr>") . "\<cr>")
endfunction

command! -range ExecOnTerm call s:exec_on_term(<line1>, <line2>)
nnoremap <leader>ex :ExecOnTerm<cr>
vnoremap <leader>ex :ExecOnTerm<cr>



" Startify
nnoremap <leader>st :Startify<cr>
let g:startify_lists = [
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]
let g:startify_bookmarks = [
	\ {'t': '~/Nextcloud/tasks/todo.txt'},
	\ '~/Nextcloud/Notes/db/daily.txt',
	\ '~/.config/nvim/init.vim',
	\ ]


if has('nvim')
    let g:python3_host_prog = '$HOME/.config/nvim/.venv/bin/python3'
endif

let g:slime_target = "tmux"
let g:slime_python_ipython = 1

nmap <leader>tt <Plug>SlimeSendCell


" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


" Git diff aliases
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>



" let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
"
set diffopt+=vertical


"Gutentags
let g:gutentags_modules = ['ctags']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']

let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]
