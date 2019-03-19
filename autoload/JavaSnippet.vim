if !exists('g:JavaSnippet#snippet_first')
    let g:JavaSnippet#snippet_first = 0
endif

"好きなタイミングでJavaのsnippet補完を呼べるようにする
function! JavaSnippet#snippet(access, class) abort
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

function! JavaSnippet#snippet_first() abort
    if g:JavaSnippet#snippet_first
        call append('0', "public class ".expand("%:r"). " {")
        if expand("%:r") ==# 'Main'
            call append('1', "    public static void main(String[] args) {")
            call append('2', '')
            call append('3', "    }")
            "call append('4', '}')"
        else
            "call append('2', '}')"
        endif
    endif
endfunction

" moldは型

function! JavaSnippet#getter(mold, fieldname) abort
    let filetype = s:Filetype()
    if strlen(filetype) == ''
        echomsg 'このファイルの拡張子はjavaではありません'
        return 0
    else
        call append('$', "public"." ".a:mold." get".a:fieldname.'()'.' {')
        call append('$', '    return this.name;')
        call append('$', '}')
    endif
endfunction

function! JavaSnippet#setter(mold, fieldname) abort
    call append('$', "public"." ".a:mold." set".a:fieldname.'()'.' {')
    call append('$', '    this.name = name;')
    call append('$', '    "System.out.println(this.name);')
    call append('$', '}')
endfunction

function! JavaSnippet#switch_on()
    if g:JavaSnippet#snippet_first == 0
        let g:JavaSnippet#snippet_first = 1
    endif
endfunction

function! JavaSnippet#switch_off()
    if g:JavaSnippet#snippet_first == 1
        let g:JavaSnippet#snippet_first = 0
    endif
endfunction

function! JavaSnippet#InsertMethod(accessname, mold, methodname) abort
    call append('$', a:accessname." static"." ".a:mold." ".a:methodname."() {")
    call append('$', "}")
endfunction
