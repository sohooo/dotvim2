# sohooo's VIM config

This setup is based on various sources all around github. Huge credits go to these projects:

- [bling.vim](https://github.com/bling/dotvim)
- [spf13-vim](https://github.com/spf13/spf13-vim)
- [mutewinter's dotvim](https://github.com/mutewinter/dot_vim)
- [skwp's dotfiles](https://github.com/skwp/dotfiles)


## Features

- complete package with useful plugins, bindings and colorschemes
- fully portable; place this package and `vimrc` anywhere you want
- nicely structured and fine-tuned `vimrc` config for easy extension/modification
- enhanced markdown editing with folding, fenced code highlighting and TOC
- distraction-free writing mode with focus on current paragraph


## Installation

1. Put this repo in a place you like, for example: `git clone http://github.com/sohooo/dotvim2.git ~/.dotvim`
2. Start Vim and install plugins: `vim -u ~/.dotvim/vimrc -c PlugInstall`
3. Bonus: create an alias to use your Vim installation, like: `alias v='vim -u ~/.dotvim/vimrc'`; this way, we don't interfere with the system Vim installation.
4. Enjoy!


## Bindings

Here's a list of some useful keyboard bindings:

* `s`       vim-sneak; like 'f', but multiple lines
* `,f`      find file w/ CtrlP
* `,d`      toggle NerdTree
* `,u`      toggle UndoTree
* `,v`      toggle GoldenView autoresizing (enabled on start)
* `,w`      toggle distraction-free writing
* `gcc`     toggle comment on/off
* `jj`      remap of ESC; this rox!
* `F9`      toggle paste/nopaste
* `F10`     toggle number/nonumber
* `,tt`     change tabs


### Neosnippets

* `ctrl-p | ctrl-n`  cycle through elements
* `ctrl-k`           complete snippet


### CtrlP

* `<c-jk>`  movement
* `<c-f> and <c-b>` to cycle between modes.
* `<c-t>`   open in tab
* `<c-v>`   open in vertical split
* `<c-x>`   open in horizontal split


### Fugitive

* `:Gdiff`    show diff
* `:Gstatus`  toggle files with `-`


### Tabular

* `,t=`  align =
* `,t:`  align :
* `,tt`  align =>


### Markdown

* `:Toc`  display table of contents
* `zm, zO, ...`  usual folding syntax
*  fenced code blocks


## Other Tips

### Statusbar Fonts
For an even prettier status bar, use one of the patched fonts from the [Powerline wiki](https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts).


### Distraction-free Writing
Distraction-free writing a la iAWriter is supported via [a plugin from LakTEK](http://laktek.com/2012/09/05/distraction-free-writing-with-vim/). Toggle the view with `F4`, and don't forget to disable the OSX native fullscreen view:

    defaults write org.vim.MacVim MMNativeFullScreen 0

You also need the [Cousine Font from Google](http://www.fontsquirrel.com/fonts/cousine) as a free alternative to Nitti Light.
