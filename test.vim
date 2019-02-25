command! -nargs=0 UtestAppend call UtestAppend()
"nargs=0は，引数を取らないという意味"

"sのスコープは現在のスクリプトファイルにローカルという意味
function! UtestAppend()
    let target = s:GetTargetName()
    echo target
    if strlen(target) == ''
        echomsg 'Not test target file: '.expand('%')
        return 0
    endif
    let testfile = s:GetTestFileName(target)
    if strlen(testfile) == '' || target ==# testfile
        echomsg 'Cannot generate test file name: ' . target
    endif

    call s:OpenFile(testfile)
endfunction

"filetypeを判断する関数"
"javaじゃないと，nullを返す関数"
function! s:GetTargetName()
    if expand('%:e') ==# 'java'
        return expand('%')
    else
        return ''
    endif
endfunction

function! s:GetTestFileName(target)
    let testfile = a:target

    "substituteは置換コマンド"
    "testfileが置換対象"
    ".javaはパターン(検索内容)"
    "Testは置き換え文字列"
    "最後の引数はフラグ(未指定だと，最初の一個目の置換対象を置換する)"

    let testfile = substitute(testfile, '\&lt;/src/main/java', 'src/test/java', '')
    let testfile = substitute(testfile, '\.java$', 'Test&', '')
    return testfile
endfunction

function! s:OpenFile(filepath)
    execute 'split ' .a:filepath
    let dir = expand('%:h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
endfunction
