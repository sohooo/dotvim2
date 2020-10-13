" DBSys Logfiles
autocmd BufNewFile,BufReadPost *.log 
      \ set filetype=logfile  |
      \ set foldmethod=marker |
      \ set foldlevel=0

