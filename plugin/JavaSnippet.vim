if exists('g:loaded_JavaSnippet')
    finish
endif

let g:loaded_JavaSnippet = 1

"インデントコマンドを定義
command! -nargs=0 Indent execute("normal " . "gg=G")
command! -nargs=0 SwitchOn call Javasnippet#switch_on()
command! -nargs=0 SwitchOff call Javasnippet#switch_off()
command! -nargs=+ Javasnippet call Javasnippet#snippet(<f-args>)
command! -nargs=+ Getter call Javasnippet#getter(<f-args>)
command! -nargs=+ Setter call Javasnippet#setter(<f-args>)

augroup plugin-JavasnippetFirst
    autocmd!
    autocmd FileType java call Javasnippet#snippet_first()
augroup END
