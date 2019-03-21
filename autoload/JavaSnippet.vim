"import文の補完候補をリストに追加

"Todo listを別ファイルから参照する方法 and 自分で簡易的に補完候補を定義する方法
let s:import_words = { 'java.util.Ramdom;':1, 'java.util.Carender;':2 }

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

"staticつけるかつけないかで場合分けするか考えよう
function! JavaSnippet#InsertMethod(accessname, mold, methodname) abort
    call append('$', a:accessname." static"." ".a:mold." ".a:methodname."() {")
    call append('$', "}")
endfunction

function!  JavaSnippet#CompleteImport() abort
    call feedkeys("iimport \<C-x>\<C-u>")
endfunction

function! JavaSnippet#SuggestImport(findstart, base)
    if a:findstart != 0
        " 補完開始位置を決定する

        "カーソルの直前の位置を計算する"
        let prev_pos = col('.') - 1

        " カーソルのある行のカーソルの前までの文字列を取得"
        let before_str = getline('.')[0:prev_pos]

        " before_strから正規表現を用いて最後の単語を切り出している"
        " \mはmagic
        let last_word = matchstr(before_str, '\m\(\k\+\)$')
        let prefix_len = len(last_word)
        let start_pos = prev_pos - prefix_len
        return prefix_len <= 0 ? -1 : start_pos
    else
        "補完候補を検索する
        let items = filter(keys(s:import_words), 'stridx(v:val, a:base) == 0')
        return items
    endif
endfunction

" 補完候補をdict/JavaImport.txtから読み出せるようにする
function! JavaSnippet#fileread()
    let filename = "../dict/JavaImport.txt"
    let lines = readfile(filename, 10)
    for line in lines
        echo line
    endfor
endfunction


"ユーザー定義コマンドを定義
set completefunc=JavaSnippet#SuggestImport
