" Python style "
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
highlight ColorColumn ctermbg=darkgray
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

