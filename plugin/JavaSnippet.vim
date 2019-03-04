if exists('g:loaded_JavaSnippet')
    finish
endif

let g:loaded_JavaSnippet = 1
command! -nargs=+ Javasnippet call Javasnippet(<f-args>)

augroup plugin-JavasnippetFirst
    autocmd!
    autocmd FileType java call JavasnippetFirst()
augroup END
