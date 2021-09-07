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

set nu
set relativenumber
set ignorecase
set smartcase
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

if (exists('&ide'))
  set ideajoin
  set ideastatusicon=gray
  set idearefactormode=keep
  set NERDTree
  set easymotion
  set surround
  set NERDTree

  nnoremap nt :NERDTree<Cr>
  map <leader>f <Action>(GotoFile)
  map <leader>g <Action>(FindInPath)
  map <leader>b <Action>(Switcher)
  map <leader>r <Action>(GotoDeclaration)
  map <leader>d <Action>(GotoDeclaration)
  nmap <leader>h :action PreviousTab<Cr>
  nmap <leader>l :action NextTab<Cr>

else 
  " ideaVim doesn't know about this options
  set autoindent
  set nowrap
  set smarttab
  set expandtab
  set tabstop=2
  set shiftwidth=2

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
endif

" russian language in normal mode
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map ё \
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >
map Ё /|

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

nnoremap <expr> <leader>s 'i' . AllVimStrings('function')
fun! AllVimStrings(pattern)
  let result = []
  
  let prefix = ''
  let suffix = ''
  let index = 0
  let inSuffix = 0
  while index < len(a:pattern)
    let char = a:pattern[index]
    if char !=? '[' && !inSuffix
      let prefix .= char
    elseif char ==? '[' || char ==? ']'
      let inSuffix = 1
    else
      let suffix .= char
    endif
    let index += 1
  endwhile

  let result += [prefix]
  let index = 0
  while index < len(suffix)
    let prefix .= suffix[index]
    let result += [prefix]
    let index += 1
  endwhile

  let resultString = ''
  let index = 0
  while index < len(result) - 1
    let resultString .= "'" . result[index] . "' | "
    let index += 1
  endwhile
  let resultString .= "'" . result[index] . "';" 
  return resultString
endfunction

