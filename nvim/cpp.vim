" C++ style "

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent
highlight ColorColumn ctermbg=darkgray
setlocal makeprg=catkin_make\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1
" make\ -C\ ../build\ -j8
nnoremap <F7> :make<CR>
inoremap <F7> <ESC>:w \| :make<CR>
nnoremap <S-F7> :make clean all<CR>
