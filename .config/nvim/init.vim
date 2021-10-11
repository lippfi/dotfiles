set nu
set relativenumber
set ignorecase
set smartcase
set clipboard+=unnamedplus
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
nnoremap x "_x
nnoremap \ <C-w>

if (has('ide'))
  set ideajoin
  set ideastatusicon=gray
  set idearefactormode=keep
  set NERDTree
  set easymotion
  set surround
  set ReplaceWithRegister

  nnoremap nt :NERDTree<Cr>
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
else 

" ideaVim ignore -- this makes parsing faster
set autoindent
set nowrap
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2

call plug#begin('~/.config/nvim/plugged')
    Plug 'mbbill/undotree'

    " making vim beautiful
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'morhetz/gruvbox'

    " git
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'

    " kotlin
    " Plug 'udalov/kotlin-vim'

    " telescope requirements...
    " do not forget to install ripgrep (pacman knows about it)
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'fannheyward/telescope-coc.nvim'
    
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

" VIM-2428 
vnoremap <A-j> :m '>+1<Cr>gv
vnoremap <A-k> :m '<-2<Cr>gv

" telescope
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>

" coc
source $HOME/.config/nvim/plug-config/coc.vim
map <leader>r <cmd>Telescope coc references<cr>
map <leader>d <Plug>(coc-definition)

" undotree
nnoremap <leader>u <cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>

" making vim beautiful
set bg=dark
colorscheme gruvbox
let g:airline_theme='angr'

" telescope default config
lua << EOF
  require('telescope').setup{
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
      },
      file_sorter =  require'telescope.sorters'.get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      use_less = true,
      path_display = {},
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
  }
  require('telescope').load_extension('coc')
EOF
" ideaVim ignore end
endif

