"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand("~/vim-lsp.log")

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

highlight link LspErrorText GruvboxRedSign

" key mapps {{{
"   To map keys to the feature of vim-lsp, use <plug> mappings:
"   autocmd FileType python,go nmap gd <plug>(lsp-definition)
"   detail help.
"   h: vim-lsp-mapping

nmap <buffer> <F12> <Plug>(lsp-definition)
nmap <buffer> <C-]> <Plug>(lsp-definition)
" nmap <buffer> XX <plug>(lsp-document-symbol)
" nmap <buffer> XX <plug>(lsp-document-diagnostics)
nmap <buffer> K <Plug>(lsp-hover)
nmap <buffer> <C-n> <plug>(lsp-next-error)
nmap <buffer> <C-p> <plug>(lsp-previous-error)
nmap <buffer> <S-F12> <plug>(lsp-references)
nmap <buffer> <S-F6> <plug>(lsp-rename)
" nmap <buffer> XX <plug>(lsp-workspace-symbol)
nmap <buffer> =- <plug>(lsp-document-format)
nmap <buffer> <F11> <plug>(lsp-implementation)
nmap <buffer> <F2> <plug>(lsp-type-definition)
" nmap <buffer> XX <plug>(lsp-status)
" nmap <buffer> XX <plug>(lsp-code-action)

