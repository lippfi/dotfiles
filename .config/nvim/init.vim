set nu
set hlsearch
set relativenumber
set ignorecase
set smartcase
set clipboard+=unnamedplus
set scrolloff=5
let mapleader= " "

" best mapping ever
inoremap <expr> jk col(".") == 1 ? '<Esc>' : '<Esc><Right>'
" moving things around
inoremap <A-j> <Esc>:m+<Cr>i
inoremap <A-k> <Esc>:m-2<Cr>i
nnoremap <A-j> :m+<Cr>
nnoremap <A-k> :m-2<Cr>

nnoremap U <C-R>
nnoremap S :%s/
nnoremap \ <C-w>

vnoremap <C-A> :s/\d\+/\=submatch(0)+1/g<CR>:nohl<CR>
vnoremap g<C-A> :call IncrementWholeLine()<CR>


" works same as vim's default g<C-A> but increments not only the first number,
" but all the numbers in selection
" e.g.
"           val ch1 = tree.getChild(0)                              val ch1 = tree.getChild(0)
"<selection>val ch1 = tree.getChild(0)              ---g<C-A>-->    val ch2 = tree.getChild(1)
"           val ch1 = tree.getChild(0)</selection>                  val ch3 = tree.getChild(2)
function! IncrementWholeLine() range
  if has('ide')
    execute "'<,'>s/\\d\\+/\\=submatch(0)+line('.')-a:firstline+1/g"
  else
    " requires %V support :<
    execute "'<,'>s/\\%V\\d\\+\\%V/\\=submatch(0)+line('.')-a:firstline+1/g"
  endif
  noh
endfunction


if (has('ide'))
  sethandler a:vim

  set ideajoin
  set ideastatusicon=gray
  set idearefactormode=keep
  set NERDTree
  set easymotion
  set surround
  set ReplaceWithRegister
  set noideadelaymacro
  
  nnoremap nt :NERDTreeToggle<Cr>
  map <leader>f <Action>(GotoFile)
  map <leader>g <Action>(FindInPath)
  map <leader>b <Action>(Switcher)
  map <leader>r <Action>(GotoDeclaration)
  map <leader>d <Action>(GotoDeclaration)
  nmap <leader>h :action PreviousTab<Cr>
  nmap <leader>l :action NextTab<Cr>
  xmap p gr

  map <A-j> <Action>(MoveLineDown)
  map <A-k> <Action>(MoveLineUp)

  nnoremap <C-j> :tabnext<CR>
  nnoremap <C-k> :tabNext<CR>
  nnoremap <C-S-j> :tabmove +1<CR>
  nnoremap <C-S-k> :tabmove -1<CR>
endif

" ideaVim ignore
" the "ideaVim ignore" comment helps IdeaVim's parser to skip redundant lines
" what makes .vimrc parsing and IDE startup faster
set autoindent
set nowrap
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set colorcolumn=80

call plug#begin('~/.config/nvim/plugged')
    Plug 'mbbill/undotree'

    " making vim beautiful
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'

    " git
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'

    " latex
    Plug 'lervag/vimtex'

    " much better search highlighting
    Plug 'qxxxb/vim-searchhi'
call plug#end()

" VIM-2428 
vnoremap <A-j> :m '>+1<Cr>gv
vnoremap <A-k> :m '<-2<Cr>gv

" telescope
" nnoremap <leader>f <cmd>Telescope find_files<cr>
" nnoremap <leader>g <cmd>Telescope live_grep<cr>
" nnoremap <leader>b <cmd>Telescope buffers<cr>
" nnoremap <leader>h <cmd>Telescope help_tags<cr>

" undotree
nnoremap <leader>u <cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>

" making vim beautiful
set bg=dark
colorscheme gruvbox
let g:airline_theme='angr'

" fancy search
nmap n <Plug>(searchhi-n)
nmap N <Plug>(searchhi-N)
nmap * <Plug>(searchhi-*)
nmap g* <Plug>(searchhi-g*)
nmap # <Plug>(searchhi-#)
nmap g# <Plug>(searchhi-g#)
nmap gd <Plug>(searchhi-gd)
nmap gD <Plug>(searchhi-gD)
vmap n <Plug>(searchhi-v-n)
vmap N <Plug>(searchhi-v-N)
vmap * <Plug>(searchhi-v-*)
vmap g* <Plug>(searchhi-v-g*)
vmap # <Plug>(searchhi-v-#)
vmap g# <Plug>(searchhi-v-g#)
vmap gd <Plug>(searchhi-v-gd)
vmap gD <Plug>(searchhi-v-gD)
nmap <silent> <C-L> <Plug>(searchhi-clear-all)
vmap <silent> <C-L> <Plug>(searchhi-v-clear-all)
let g:searchhi_user_autocmds_enabled = 1
let g:searchhi_redraw_before_on = 1

command Tex VimtexCompile
let g:vimtex_view_method = 'zathura'
" ideaVim ignore end

