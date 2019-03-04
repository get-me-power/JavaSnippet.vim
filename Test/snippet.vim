command! -nargs=0 Javasnippet call Javasnippet()
"nargs=0は引数を取らないという意味

function! Javasnippet()
    let filetype = s:Filetype()
    if strlen(filetype) == ''
        echomsg 'このファイルの拡張子はjavaではありません: '. expand('%')
        return 0
    else
        call s:Writebuffor()
    endif
endfunction " Javasnippet

function! s:Filetype()
    if expand('%:e') ==# 'java'
        return expand('%')
    else
        return ''
    endif
endfunction

function! s:Writebuffor()
    "$は，バッファの末尾
    call append('$', "public class ".expand("%:r"). " {")
        if expand("%:r") ==# 'Main'
        call append('$', "    public static void main(String[] args) {")
        call append('$', '')
        call append('$', "    }")
        call append('$', "}")
    else
        call append('$', "}")
    endif
endfunction
