" global setting {{{1
" ==============================================================================
let g:lsp_preview_doubletap = [function('lsp#ui#vim#output#closepreview')]
let g:lsp_preview_autoclose = 0

let g:lsp_insert_text_enabled = 0

let g:lsp_highlight_references_enabled = 1

let g:lsp_diagnostics_echo_cursor = 1

let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '🧨'}
let g:lsp_signs_warning = {'text': '⚠️'}
let g:lsp_signs_information = {'text': 'ℹ️'}
let g:lsp_signs_hint = {'text': '💁'}

let g:lsp_async_completion = 1

" highlight {{{1
" ==============================================================================
highlight link LspErrorText GruvboxRedSign
highlight lspReference term=underline cterm=underline

highlight PopupWindow ctermfg=LightCyan ctermbg=Magenta guibg=NONE guifg=LightCyan
augroup lsp_float_colours
    autocmd!
    autocmd User lsp_float_opened
                \ call win_execute(lsp#ui#vim#output#getpreviewwinid(),
                \		       'setlocal wincolor=PopupWindow')
augroup end

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
                    \ 'workspace_config': {'gopls': {
                    \     'staticcheck': v:false,
                    \     'completeUnimported': v:true,
                    \     'caseSensitiveCompletion': v:true,
                    \     'usePlaceholders': v:true,
                    \     'completionDocumentation': v:true,
                    \     'watchFileChanges': v:true,
                    \     'hoverKind': 'SynopsisDocumentation',
                    \     'deepCompletion': v:true,
                    \ }},
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
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
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

" efm {{{2
if executable('efm-langserver')
  augroup LspEFM
    au!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'efm-langserver',
        \ 'cmd': {server_info->['efm-langserver', '-c='.$HOME.'/.config/efm-langserver/config.yaml']},
        \ 'whitelist': ['go'],
        \ })
  augroup END
endif

