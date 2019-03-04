"command! -nargs=+ Javasnippet call Javasnippet(<f-args>)
"nargs=0は引数を取らないという意味

"好きなタイミングでJavaのsnippet補完を呼べるようにする
function! Javasnippet#snippet(access, class) abort
    let filetype = s:Filetype()
    let accessname = a:access
    let classname = a:class
    if strlen(filetype) == ''
        echomsg 'このファイルの拡張子はjavaではありません: '. expand('%')
        return 0
    else
        call s:Writebuffor(accessname, classname)
    endif
endfunction " Javasnippet

function! s:Filetype() abort
    if expand('%:e') ==# 'java'
        return expand('%')
    else
        return ''
    endif
endfunction "Filetype

function! s:Writebuffor(accessname, classname) abort
    "$は，バッファの末尾
    call append('$', a:accessname." class ".a:classname. " {")
        if a:classname ==# 'Main'
        call append('$', "    public static void main(String[] args) {")
        call append('$', '')
        call append('$', "    }")
        call append('$', "}")
    else
        call append('$', "}")
    endif
endfunction "Writebuffor

function! Javasnippet#snippet_first() abort
    call append('0', "public class ".expand("%:r"). " {")
    if expand("%:r") ==# 'Main'
        call append('1', "    public static void main(String[] args) {")
        call append('2', '')
        call append('3', "    }")
        call append('4', "}")
    else
        call append('2', "}")
    endif
endfunction 
