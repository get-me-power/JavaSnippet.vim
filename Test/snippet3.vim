function! JavasnippetFirst()
    let filetype = s:Filetype()
    if strlen(filetype) == ''
        echomsg 'このファイルの拡張子はjavaではありません: '. expand('%')
        return 0
    else
        call s:WritebufforFirst()
    endif
endfunction " Javasnippet

function! s:Filetype()
    if expand('%:e') ==# 'java'
        return expand('%')
    else
        return ''
    endif
endfunction

function! s:WritebufforFirst()
    "$は，バッファの末尾
    call append('0', "public class ".expand("%:r"). " {")
        if expand("%:r") ==# 'Main'
        call append('1', "    public static void main(String[] args) {")
        call append('2', '')
        call append('3', "    }")
        call append('4', "}")
    else
        call append('5', "}")
    endif
endfunction

autocmd FileType java call Javasnippet()
