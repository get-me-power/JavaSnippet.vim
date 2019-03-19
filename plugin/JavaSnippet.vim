if exists('g:loaded_JavaSnippet')
    finish
endif

let g:loaded_JavaSnippet = 1

command! -nargs=0 Indent execute("normal " . "gg=G")
command! -nargs=0 SwitchOn call JavaSnippet#switch_on()
command! -nargs=0 SwitchOff call JavaSnippet#switch_off()
command! -nargs=+ Javasnippet call JavaSnippet#snippet(<f-args>)
command! -nargs=+ Getter call JavaSnippet#getter(<f-args>)
command! -nargs=+ Setter call JavaSnippet#setter(<f-args>)
command! -nargs=+ Method call JavaSnippet#InsertMethod(<f-args>)
augroup plugin-JavasnippetFirst
    autocmd!
    autocmd FileType java call JavaSnippet#snippet_first()
augroup END
