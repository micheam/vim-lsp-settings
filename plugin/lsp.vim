" global setting {{{1
" ==============================================================================
let g:lsp_preview_doubletap = [function('lsp#ui#vim#output#closepreview')]
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '🧨'}
let g:lsp_signs_warning = {'text': '⚠️'}
let g:lsp_signs_information = {'text': 'ℹ️'}
let g:lsp_signs_hint = {'text': '💁'}
let g:lsp_async_completion = 1

" highlight {{{1
" ==============================================================================
highlight link LspErrorText GruvboxRedSign
highlight lspReference term=underline,bold cterm=underline,bold

" filetypes {{{1
" ==============================================================================

" go {{{2
" ==============================================================================
if executable('gopls')
    augroup LspGo
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'go-lang',
                    \ 'cmd': {server_info->['gopls']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'go.mod'))},
                    \ 'whitelist': ['go'],
                    \ })
        autocmd FileType go setlocal omnifunc=lsp#complete
        "autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
        "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
        "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
    augroup END
elseif executable('bingo')
    augroup LspGo
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'go-lang',
                    \ 'cmd': {server_info->['bingo', '-mode', 'stdio']},
                    \ 'whitelist': ['go'],
                    \ })
        autocmd FileType go setlocal omnifunc=lsp#complete
    augroup END
else
    :echomsg "vim-lsp for go unavailable"
endif

" javascript {{{2
if executable('typescript-language-server')
    augroup LspJavascript
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'javascript-language-server',
                    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
                    \ 'whitelist': ['javascript', 'javascript.jsx'],
                    \ })
        autocmd FileType javascript setlocal omnifunc=lsp#complete
    augroup END
else
    :echomsg "vim-lsp for javascript unavailable"
endif

" typescript {{{2
if executable('typescript-language-server')
    augroup LspTypeScript
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'typescript-language-server',
                    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
                    \ 'whitelist': ['typescript'],
                    \ })
        autocmd FileType typescript setlocal omnifunc=lsp#complete
    augroup END
else
    :echomsg "vim-lsp for typescript unavailable"
endif

" vue {{{2
if executable('vls')
    augroup LspVue
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'vue',
                    \ 'cmd': {server_info->['vls']},
                    \ 'whitelist': ['vue'],
                    \ })
        autocmd FileType vue setlocal omnifunc=lsp#complete
    augroup END
else
    :echomsg "vim-lsp for vue unavailable"
endif

