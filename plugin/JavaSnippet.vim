if exists('g:loaded_JavaSnippet')
    finish
endif

let g:loaded_JavaSnippet = 1
command! -nargs=+ Javasnippet call Javasnippet#snippet(<f-args>)

augroup plugin-JavasnippetFirst
    autocmd!
    autocmd FileType java call Javasnippet#snippet_first()
augroup END
