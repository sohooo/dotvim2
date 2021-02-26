" =========================================
" Who:   Sven Sporer <<||>> sohooo
" Where: https://github.com/sohooo/dotvim2
" =========================================
" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" intro and credits {{{
"
" This is a refresh of my dotfiles from https://github.com/sohooo/vimfiles
" It is designed to be fully portable. This vimrc can be placed anywhere.
"
" Usage
" -----
"
" 0) clone this repo and put it where you want (doesnt have to be ~/.vim)
" 1) install all plugins:
"     vim -u vimrc
"     :PlugInstall
" 2) create alias for nice use:
"     alias v='mvim /path/to/vimrc'
" 3) happy VIMing!
"
"
" Links
" -----
"
" This config can be found at: https://github.com/sohooo/dotvim
" The setup is also heavily inspired by the following configurations:
"   - https://github.com/bling/dotvim
"   - https://github.com/spf13/spf13-vim
"
" }}}

" environment & Plug {{{
  set nocompatible              " be iMproved, required
  filetype off                  " required

  " set clean, default 'runtimepath' (without ~/.vim folders)
  let &runtimepath = printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)

  " what is the name of the directory containing this file?
  " The usage is: vim -u /path/to/portable/vim/.vimrc
  let s:portable = expand('<sfile>:p:h')

  " add the directory to 'runtimepath'
  " various paths
  let g:mods   = s:portable . '/mods'       " local modifications
  let g:readme = s:portable . '/README.md'  " README.md of this project
  let g:vimrc  = expand('<sfile>')          " this vimrc

  let &runtimepath = printf('%s,%s,%s/after,%s/bundle/Plug.vim', s:portable, &runtimepath, s:portable, s:portable)

  " Plugins managed by vim-plug: https://github.com/junegunn/vim-plug
  " Tell vim-plug where to put plugins: /path_of_this_file/bundle
  call plug#begin(printf('%s/bundle', s:portable))

  " load local ./mods
  Plug printf('%s/logfile', g:mods)
" }}}

" detect OS {{{
  let s:is_windows = has('win32') || has('win64')
  let s:is_cygwin = has('win32unix')
  let s:is_macvim = has('gui_macvim')
  let s:is_unix   = has('unix')
" }}}

" common options {{{
  set ruler              " Ruler on
  set number             " Line numbers on
  set laststatus=2       " Always show the statusline
  set cmdheight=1        " height of commandbar
  set notitle            " set terminal's title
  set scrolloff=3        " show 3 lines of context around cursor
  set showmode           " display mode you're in
  set wrap               " turn on line wrapping
  set numberwidth=5      " width of line numbers
  set antialias          " MacVim: smooth fonts
  set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
  set fillchars=diff:⣿,vert:│
  " set showbreak=↪
  "
  set nobackup
  set noswapfile

  " if has('conceal')
  "   set conceallevel=1
  "   set listchars+=conceal:Δ
  " endif

  if s:is_macvim
    " set guifont=Sauce\ Code\ Powerline:h13
    "set guifont=FiraCode-Regular:h14
    " set guifont=Sauce\ Code\ Powerline\ Light:h13
    set guifont=Hasklig-Regular:h14
    set macligatures
    " set transparency=1

    " Dash.app integration
    Plug 'rizzatti/dash.vim'

    " copy with syntax highlighting: CopyRTF
    Plug 'zerowidth/vim-copy-as-rtf'

    " Hide Toolbar in MacVim
    if has("gui_running")
      set guioptions=egmrt
    endif

  elseif s:is_windows
     " Windows
    set guifont=Consolas:h10:cANSI
    set guioptions-=T " disable: include Toolbar
    set guioptions-=m " disable: Menu bar is present
    set guioptions-=r " disable: right-hand scrollbar always present

    " Set height and width on Windows
    set lines=60
    set columns=120

    " Windows has a nasty habit of launching gVim in the wrong working directory
    cd ~
  endif

  syntax enable
  set t_ti=
  set t_te=
  set t_Co=256           " number of supported colors
  set autoread           " Automatically reload changes if detected
  set wildmenu           " Turn on WiLd menu
  set hidden             " Change buffer - without saving
  set history=768        " Number of things to remember in history.
  set cf                 " Enable error files & error jumping.
  set clipboard+=unnamed " Yanks go on clipboard instead.
  set autowrite          " Writes on make/shell commands
  set timeoutlen=2500    " Time to wait for a command (after leader for example)
  set foldlevel=0        " enable folding
  set foldlevelstart=99  " Open all folds on start
  set formatoptions=crql

  set ignorecase         " Case insensitive search
  set smartcase          " Non-case sensitive search
  set incsearch
  set hlsearch

  set showmatch          " Show matching brackets.
  set matchtime=2        " How many tenths of a second to blink

  set noerrorbells
  set visualbell         " disables beep in macvim
  set t_vb=

  set mousehide  " Hide mouse after chars typed
  set mouse=a    " Mouse in all modes

  " Better complete options to speed it up
  set complete=.,w,b,u,U

  set tabstop=2
  set backspace=2   " Delete everything with backspace
  set shiftwidth=2  " Tabs under smart indent
  set cindent
  set autoindent
  set smarttab
  set expandtab
" }}}

" bindings {{{
  let mapleader=","
  nmap <silent> <leader>s :set spell!<CR>
  nmap <silent> <leader>vim :e <sfile><CR>
  nmap <leader>u :syntax sync fromstart<cr>:redraw!<cr>

  " jenkins pipeline linting for .groovy files
  au FileType groovy nmap <leader>l :!ssh -l $GIT_AUTHOR_NAME -p 58888 JENKINS_HOST declarative-linter < %<cr>

  " puppet syntax linting
  au FileType puppet nmap <leader>l :!puppet-lint %<cr>

  " window movement
  nmap <silent> <C-h> :wincmd h<CR>
  nmap <silent> <C-j> :wincmd j<CR>
  nmap <silent> <C-k> :wincmd k<CR>
  nmap <silent> <C-l> :wincmd l<CR>

  " fixes common typos
  command W w
  command Wq wq
  command Wqa wqa
  command Q q
  command Qa qa
  map <F1> <Esc>
  imap <F1> <Esc>

  " remap escape; this rox
  imap jj <Esc>
  " Make line completion easier
  imap <C-l> <C-x><C-l>

  " keep the cursor in place while joining limes
  nnoremap J mzJ`z
  " keep search matches in the middle of the window.
  nnoremap n nzzzv
  nnoremap N Nzzzv
  " same when jumping around
  nnoremap g; g;zz
  nnoremap g, g,zz

  " toggle paste mode on/off
  map <F9> :set paste!<cr>:set paste?<cr>
  " toggle line numbers
  map <F10> :set number!<cr>:set number?<cr>

  " display help with 'K'
  au BufReadPost *.rb set keywordprg=ri
  au BufReadPost *.pp set keywordprg=puppet\ describe

  " easy tab switching
  nmap tt :tabnext<cr>
  map  tt :tabnext<cr>
  nmap <C-t> :tabnew<cr>
  imap <C-t> <Esc>:tabnew<cr>

  " same indent behaviour in visual mode
  vmap > >gv
  vmap < <gv
  " make Y behave like other capitals
  map Y y$

  " improve up/down movement on wrapped lines
  nnoremap j gj
  nnoremap k gk

  " force saving files that require root permission
  cmap w!! %!sudo tee > /dev/null %

  " show README to help with bindings
  nmap <silent><leader>h   :exe ":tabnew ". g:readme<cr>
  nmap <silent><leader>vim :exe ":tabnew ". g:vimrc<cr>
"}}}

" language
" plugins or syntax highlighting for a language or library {{{
  Plug 'tpope/vim-surround'         "quoting/parenthesizing made simple
  Plug 'tpope/vim-endwise'          "wisely add 'end' in ruby, etc
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-dispatch'
  Plug 'andrewradev/splitjoin.vim'
  Plug 'jiangmiao/auto-pairs' "{{{
    au FileType markdown let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
    au Filetype vim      let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'"}
  "}}}

  Plug 'mxw/vim-jsx'
  Plug 'elzr/vim-json'
  Plug 'tpope/vim-cucumber'
  Plug 'rhysd/vim-crystal'
  Plug 'slim-template/vim-slim'
  Plug 'timcharper/textile.vim'
  Plug 'thoughtbot/vim-rspec'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'elixir-lang/vim-elixir'
  Plug 'tpope/vim-haml'
  Plug 'fatih/vim-go'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'kchmck/vim-coffee-script'
  Plug 'mmalecki/vim-node.js'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'wavded/vim-stylus'
  Plug 'digitaltoad/vim-jade'
  Plug 'juvenn/mustache.vim'
  Plug 'Valloric/MatchTagAlways'
  Plug 'othree/html5.vim'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'groenewege/vim-less'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'ap/vim-css-color'
  Plug 'hdima/python-syntax'
  Plug 'rodjek/vim-puppet'
  Plug 'pearofducks/ansible-vim'
  Plug 'sheerun/vim-polyglot'

" ruby
  Plug 'vim-ruby/vim-ruby'
  Plug 'ruby-formatter/rufo-vim' "{{{
    let g:rufo_auto_formatting = 0
    let g:rufo_errors_buffer_position = 'bottom'
    let g:rufo_silence_errors = 0
  "}}}

" rails
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rails'
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'

" elixir
  Plug 'slashmili/alchemist.vim'

" rust
  Plug 'rust-lang/rust.vim' "{{{
    let g:rustfmt_autosave = 1
  "}}}

" go
  Plug 'fatih/vim-go' "{{{
    let g:go_version_warning = 0
  " }}}

" }}}

" completion
" plugins that reduce typing and complete code {{{
  " a fast one
  " Plug 'ajh17/VimCompletesMe' "{{{
  " "}}}

  " vim 7.x compatible, but a bit slower
  Plug 'Shougo/neocomplcache.vim' "{{{
    let g:neocomplcache_enable_at_startup=1
    let g:neocomplcache_enable_fuzzy_completion=1
    inoremap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-h>"
    inoremap <expr><c-k>   pumvisible() ? "\<C-p>" : "\<C-h>"
  "}}}

  " modern
  "Plug 'Valloric/YouCompleteMe' "{{{
  "  let g:ycm_complete_in_comments_and_strings=1
  "  let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
  "  let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
  "  let g:ycm_filetype_blacklist={'unite': 1}
  "}}}
  "Plug 'SirVer/ultisnips' "{{{
  "  let g:UltiSnipsExpandTrigger="<tab>"
  "  let g:UltiSnipsJumpForwardTrigger="<tab>"
  "  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  "  let g:UltiSnipsSnippetsDir=printf('%s/bundle/vim-snippets/snippets', s:portable)
  "}}}

  Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/neosnippet.vim' "{{{
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
    let g:neosnippet#enable_snipmate_compatibility=1
    let g:neosnippet#snippets_directory=printf('%s/bundle/vim-snippets/snippets,%s/snippets', s:portable, s:portable)
  "}}}
  "Plug 'ervandew/supertab'
  "Plug 'honza/vim-snippets'
  "Plug 'garbas/vim-snipmate'
"}}}

" writing
" plugins and settings for disctraction-free writing {{{
  nmap <leader>w :Goyo<CR>
  Plug 'junegunn/goyo.vim' "{{{
    function! s:goyo_enter()
      silent !tmux set status off
      set noshowmode
      set noshowcmd
      set scrolloff=999
      Limelight
    endfunction

    function! s:goyo_leave()
      silent !tmux set status on
      set showmode
      set showcmd
      set scrolloff=5
      Limelight!
    endfunction

    autocmd! User GoyoEnter
    autocmd! User GoyoLeave
    autocmd  User GoyoEnter nested call <SID>goyo_enter()
    autocmd  User GoyoLeave nested call <SID>goyo_leave()
  "}}}
  Plug 'junegunn/limelight.vim' "{{{
    let g:limelight_default_coefficient = 0.7
  "}}}

  " vim-orgmode setup; needs python
  "Plug 'jceb/vim-orgmode'
  "Plug 'vim-scripts/utl.vim'
  "Plug 'vim-scripts/SyntaxRange' " @begin=c@ ... @end=c@

" }}}

" code display
" plugins and colorschemes that enhance code display {{{
  Plug 'mhartington/oceanic-next'   " OceanicNext; airline: oceanicnext
  Plug 'joshdick/onedark.vim'       " onedark; +airline
  Plug 'cocopon/iceberg.vim'        " iceberg; +airline
  Plug 'dracula/vim'
  Plug 'tomasr/molokai'
  Plug 'w0ng/vim-hybrid' " hybrid
  Plug 'morhetz/gruvbox'
  Plug 'cocopon/iceberg.vim'
  Plug 'wolf-dog/nighted.vim'
  Plug 'croaker/mustang-vim' " mustang
  Plug 'romainl/Apprentice' " apprentice
  Plug 'jacoborus/tender.vim' "tender
  Plug 'gosukiwi/vim-atom-dark' " atom-dark
  Plug 'noahfrederick/vim-hemisu' " hemisu
  Plug 'danilo-augusto/vim-afterglow'
  Plug 'arcticicestudio/nord-vim'  " nord
  Plug 'altercation/vim-colors-solarized' " solarized
  Plug 'kristijanhusak/vim-hybrid-material' " hybrid*
  Plug 'nanotech/jellybeans.vim' "{{{
    "let g:jellybeans_use_lowcolor_black = 0
  "}}}
" }}}

" integrations
" plugins that integrate Vim with external tools or the OS {{{
  " FIXME: replace with `ale` on Vim 8
  " https://github.com/dense-analysis/ale
  Plug 'vim-syntastic/syntastic' "{{{
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_style_error_symbol = '✠'
    let g:syntastic_warning_symbol = '∆'
    let g:syntastic_style_warning_symbol = '≈'
    " choose latest rubies as interpreter
    let s:rubies = '/opt/rubies'
    let s:rubies_261 = s:rubies . '/ruby-2.6.1/bin/ruby'
    let s:rubies_260 = s:rubies . '/ruby-2.6.0/bin/ruby'
    let s:rubies_238 = s:rubies . '/ruby-2.3.8/bin/ruby'
    let s:rubies_222 = s:rubies . '/ruby-2.2.2/bin/ruby'
    let s:rubies_latest = s:rubies_261

    if filereadable(s:rubies_latest)
      let g:syntastic_ruby_mri_exec = s:rubies_latest
    elseif filereadable(s:rubies_260)
      let g:syntastic_ruby_mri_exec = s:rubies_260
    elseif filereadable(s:rubies_238)
      let g:syntastic_ruby_mri_exec = s:rubies_238
    elseif filereadable(s:rubies_222)
      let g:syntastic_ruby_mri_exec = s:rubies_222
    else
      "use system rubies"
      let g:syntastic_ruby_mri_exec = 'ruby'
    endif
  "}}}

  Plug 'christoomey/vim-tmux-navigator' "{{{

  "}}}

"}}}

" interface
" plugins that add or change a UI element {{{
  Plug 'sickill/vim-pasta'          "pasting with indentation adjusted to destination context
  Plug 'tpope/vim-fugitive'         "Git wrapper so awesome, it should be illegal
  Plug 'vim-scripts/gitignore'      "Set 'wildignore' from ./.gitignore
  Plug 'junegunn/vim-peekaboo'      "show contents of registers on demand
  "Plug 'mhinz/vim-startify'         "fancy start screen for Vim
  "Plug 'gregsexton/gitv'            "gitk-like extension for vim-fugitive
  "Plug 'junegunn/vim-emoji'         ":smiley:
  "
  Plug 'janko-m/vim-test' "{{{
    nmap <leader>tn :TestNearest<CR>
    nmap <leader>tf :TestFile<CR>
    nmap <leader>ts :TestSuite<CR>
    nmap <leader>tl :TestLast<CR>
    nmap <leader>tg :TestVisit<CR>
  "}}}

    let test#ruby#rspec#executable = './rspec'
    let test#ruby#cucumber#executable = './cucumber'

  " autoclose tags
  Plug 'alvan/vim-closetag' "{{{
    let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx'
  "}}}

  Plug 'luochen1990/rainbow'

  " Plug 'TaDaa/vimade' "{{{
  "   let g:vimade = {
  "     \ "normalid": '',
  "     \ "normalncid": '',
  "     \ "basefg": '',
  "     \ "basebg": '',
  "     \ "fadelevel": 0.6,
  "     \ "colbufsize": 15,
  "     \ "rowbufsize": 15,
  "     \ "checkinterval": 100,
  "     \ "usecursorhold": 0,
  "     \ "detecttermcolors": 0,
  "     \ 'enablesigns': 0,
  "     \ 'signsretentionperiod': 4000,
  "     \ 'enablefocusfading': 0
  "   \ }
  " "}}}

  Plug 'bling/vim-airline' "{{{
    let g:airline_theme='iceberg'
    " enable powerline fonts on Mac
    if s:is_macvim
      let g:airline_powerline_fonts=1
    endif
    if !exists('g:airline_powerline_fonts')
      " Use the default set of separators with a few customizations
      let g:airline_left_sep='›'  " Slightly fancier than '>'
      let g:airline_right_sep='‹' " Slightly fancier than '<'
    endif
  "}}}

  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } "{{{
    let g:undotree_SplitLocation='botright'
    let g:undotree_SetFocusWhenToggle=1
    nnoremap <leader>u :UndotreeToggle<CR>
  "}}}

  Plug 'scrooloose/nerdtree' "{{{
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'Xuyuanp/nerdtree-git-plugin'
    let NERDTreeChDirMode=0
    let NERDTreeDirArrows=1
    let NERDTreeHighlightCursorline=1
    let NERDTreeIgnore=['\.git$','\.hg']
    let g:NERDTreeMinimalUI=1
    let NERDTreeQuitOnOpen=0
    let NERDTreeShowBookmarks=0
    let NERDTreeShowHidden=1
    let NERDTreeShowLineNumbers=0
    nnoremap <leader>d :NERDTreeToggle<CR>
  "}}}

  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' } "{{{
    nnoremap <leader>tb :TagbarToggle<CR>
  "}}}

  if has('signs')
    Plug 'airblade/vim-gitgutter' "{{{
      let g:gitgutter_enabled = 1
      let g:gitgutter_realtime = 1
      let g:gitgutter_eager = 1

      " nmap ]c <Plug>GitGutterNextHunk
      " nmap [c <Plug>GitGutterPrevHunk
      " nmap <Leader>hs <Plug>GitGutterStageHunk
      " nmap <Leader>hu <Plug>GitGutterUndoHunk
    "}}}
  endif

  Plug 'ctrlpvim/ctrlp.vim' "{{{
    nnoremap <leader>f :CtrlP<CR>
    nnoremap <Leader>b :CtrlPBuffer<CR>

    set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

    " let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

    " CtrlP auto cache clearing.
    " ----------------------------------------------------------------------------
    function! SetupCtrlP()
      if exists("g:loaded_ctrlp") && g:loaded_ctrlp
        augroup CtrlPExtension
          autocmd!
          autocmd FocusGained  * CtrlPClearCache
          autocmd BufWritePost * CtrlPClearCache
        augroup END
      endif
    endfunction
    if has("autocmd")
      autocmd VimEnter * :call SetupCtrlP()
    endif
  "}}}

  Plug 'nathanaelkane/vim-indent-guides' "{{{
    let g:indent_guides_start_level=1
    let g:indent_guides_guide_size=1
    let g:indent_guides_enable_on_vim_startup=1
    let g:indent_guides_color_change_percent=5
    if !has('gui_running')
      let g:indent_guides_auto_colors=0
      function! s:indent_set_console_colors()
        hi IndentGuidesOdd ctermbg=235
        hi IndentGuidesEven ctermbg=236
      endfunction
      autocmd VimEnter,Colorscheme * call s:indent_set_console_colors()
    endif
  "}}}

  Plug 'camspiers/lens.vim' "{{{
    " for animation
    " Plug 'camspiers/animate.vim'

    " let g:lens#disabled = 1
    " let g:lens#animate = 0
    let g:lens#disabled_filetypes = ['nerdtree', 'fzf']

    " let g:lens#height_resize_max = 20
    " let g:lens#height_resize_min = 5
    " let g:lens#width_resize_max = 80
    " let g:lens#width_resize_min = 20
  "}}}

  " Plug 'zhaocai/GoldenView.Vim' "{{{
  "   "let g:goldenview__enable_at_startup = 0
  "   let g:goldenview__enable_default_mapping = 0
  "   nmap <leader>v <Plug>ToggleGoldenViewAutoResize
  "   " TODO: add to ignore_rule: dont resize markdown :Toc window
  "   " let g:goldenview__ignore_urule = { 'bufname': ['\[Location List\]'] }
  " "}}}
"}}}

" commands
" plugins that introduce or change a Vim command {{{
  Plug 'tomtom/tcomment_vim'        " An extensible & universal comment vim-plugin
  Plug 'tpope/vim-unimpaired'       " pairs of handy bracket mappings
  Plug 'tpope/vim-repeat'           " enable repeating supported plugin

  Plug 'roxma/vim-paste-easy' "{{{
    " let g:paste_easy_enable=0     " disable auto-paste mode
  "}}}

  Plug 'godlygeek/tabular' "{{{
    nmap <leader>t= :Tabularize /=<CR>
    vmap <leader>t= :Tabularize /=<CR>
    nmap <leader>t: :Tabularize /:\zs<CR>
    vmap <leader>t: :Tabularize /:\zs<CR>
    nmap <leader>t, :Tabularize /,\zs<CR>
    vmap <leader>t, :Tabularize /,\zs<CR>
    nmap <leader>tt :Tabularize /=>\zs<CR>
    vmap <leader>tt :Tabularize /=>\zs<CR>
  "}}}

  Plug 'plasticboy/vim-markdown' "{{{
    let g:vim_markdown_toc_autofit = 1
    let g:vim_markdown_emphasis_multiline = 0
    let g:vim_markdown_new_list_item_indent = 2
  "}}}

  Plug 'justinmk/vim-sneak' "{{{
    "move to next 'ab' => sab (s modifier)
    let g:sneak#streak = 1
  "}}}
"}}}

" functions
" functions to change the behaviour of Vim {{{

  " show trailing whitespace
  let g:show_trailing_whitespace=0
  function ToggleTrailingWhitespace ()
    if g:show_trailing_whitespace
      let g:show_trailing_whitespace=0
      match ExtraWhitespace //
    else
      let g:show_trailing_whitespace=1
      highlight ExtraWhitespace ctermbg=red guibg=red
      match ExtraWhitespace /\s\+$/
    endif
  endfunction

  map <leader>s :call ToggleTrailingWhitespace()<cr>

  " script to toggle colors and colorscheme
  function ToggleColorSettings ()
    if (&t_Co == 8)
      set t_Co=256
      colorscheme hybrid
      echo "enjoy the funky colors!"
    else
      set t_Co=8
      colorscheme default
      echo "boring colors on now"
    endif
  endfunction

  map <leader>c :call ToggleColorSettings()<cr>

  " functions to toggle active plugins
  let g:plugenabled=1
  function! PluginToggle()
    if g:plugenabled
       let g:plugenabled=0
       GitGutterDisable
       set nonumber
       if exists('#airline')
         AirlineToggle
       endif
       echom "Plugins disabled"
     else
       let g:plugenabled=1
       GitGutterEnable
       if !exists('#airline')
        AirlineToggle
       endif
       set number
       echom "Plugins enabled"
     endif
  endfunction

  nnoremap <leader>x :call PluginToggle()<cr>

  " Toggle NeoComplCache
  nmap <F11> :NeoComplCacheToggle <cr>
  imap <F11>  <c-o><F11>

"}}}

call plug#end()
filetype plugin indent on
syntax enable

" color settings {{{
  set background=dark

  " conditionally set colorscheme
  if s:is_unix && !s:is_macvim
    if $TERM == 'xterm-256color'
      colorscheme iceberg
      " colorscheme hybrid
    else
      let g:CSApprox_verbose_level=0
      colorscheme slate
    endif
  else
    colorscheme iceberg
    " colorscheme hybrid
    " colorscheme solarized
    " colorscheme mustang
    " colorscheme molokai
  endif
" }}}

" enjoy.
