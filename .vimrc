"
" My vimrc
"   updated_at 2018/04/13
"
" You will need to have vim >= 8.0
"
" extra tool
"   * ctags
"   * lynx
"   * php-cs-fixer
"   * GNU Global
"   * clang
"   * The Silver Searcher
"

" for japanese
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis,cp932

filetype off
filetype plugin indent off

" 起動時だけ
if has('vim_starting')
    " viのcompatibleモードを無効(デフォルトで無効なので不要)
    " if &compatible
    "     set nocompatible
    " endif

    let s:vimdir = $HOME . '/.vim'
    if !isdirectory(s:vimdir)
        call system('mkdir ' . s:vimdir)
    endif
endif

" dein {{{
let s:dein_enabled = 0
" 8以上のときだけプラギン適用
if v:version >= 800
    let s:dein_enabled = 1

    if has('vim_starting')
        let s:dein_dir       = s:vimdir . '/dein'
        let s:dein_github    = s:dein_dir . '/repos/github.com'
        let s:dein_repo_name = 'Shougo/dein.vim'
        let s:dein_repo_dir  = s:dein_github . '/' . s:dein_repo_name

        " deinがなかったらインストールする
        if !isdirectory(s:dein_repo_dir)
            echo 'dein is not installed, install now '
            let s:dein_repo = 'https://github.com/' . s:dein_repo_name
            call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
        endif
        let &runtimepath = &runtimepath . ',' . s:dein_repo_dir
    endif

    if dein#load_state(s:dein_dir)
        call dein#begin(s:dein_dir)
        call dein#add('Shougo/dein.vim')

        let g:dein#types#git#default_protocol='https'

        " Standard Plugins {{{
        call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
        call dein#add('Shougo/vimshell')
        call dein#add('Shougo/vimfiler')

        " luaがあればneocompleteを使う
        if has('lua')
            call dein#add('Shougo/neocomplete.vim')
        else
            call dein#add('Shougo/neocomplcache')
        endif
        call dein#add('Shougo/neosnippet')
        call dein#add('Shougo/neosnippet-snippets')

        call dein#add('thinca/vim-quickrun')
        call dein#add('osyo-manga/shabadou.vim')

        " call dein#add('scrooloose/syntastic')
        call dein#add('osyo-manga/vim-watchdogs')
        call dein#add('jceb/vim-hier') " QuickFixハイライト

        call dein#add('tpope/vim-fugitive')

        call dein#add('ctrlpvim/ctrlp.vim')
        call dein#add('osyo-manga/vim-anzu')

        if executable('ag')
            call dein#add('rking/ag.vim')
        endif

        call dein#add('junegunn/vim-easy-align')
        call dein#add('h1mesuke/vim-alignta')

        call dein#add('tomtom/tcomment_vim')
        " }}}

        " Unite {{{
        call dein#add('Shougo/unite.vim')
        call dein#add('Shougo/unite-outline')
        call dein#add('ujihisa/unite-colorscheme')
        call dein#add('Shougo/neomru.vim')
        " }}}

        " ColorScheme {{{
        call dein#add('sjl/badwolf')
        call dein#add('dracula/vim')
        call dein#add('tomasr/molokai')
        call dein#add('AlessandroYorba/Alduin')
        call dein#add('morhetz/gruvbox')
        " }}}

        " statusline {{{
        call dein#add('itchyny/lightline.vim')
        " call dein#add('Lokaltog/vim-powerline')
        " }}}

        " PHP {{{
        if executable('php')
            " call dein#add('beanworks/vim-phpfmt')
            call dein#add('stephpy/vim-php-cs-fixer')
            call dein#add('thinca/vim-ref')
        endif
        " }}}

        " HTML CSS {{{
        call dein#add('vim-scripts/HTML-AutoCloseTag')
        call dein#add('mattn/emmet-vim')
        call dein#add('othree/html5.vim')
        call dein#add('hokaccha/vim-html5validator')

        call dein#add('hail2u/vim-css3-syntax')
        call dein#add('gko/vim-coloresque')

        " call dein#add('vim-scripts/smarty-syntax')
        " }}}

        " JavaScript {{{
        call dein#add('jelera/vim-javascript-syntax')
        call dein#add('AndrewRadev/splitjoin.vim')
        call dein#add('pangloss/vim-javascript')
        call dein#add('mxw/vim-jsx')
        call dein#add('othree/yajs.vim')
        call dein#add('posva/vim-vue')

        call dein#add('elzr/vim-json')
        " }}}

        " C++ {{{
        if executable('clang')
            call dein#add('justmao945/vim-clang')
            call dein#add('osyo-manga/vim-marching')
            call dein#add('rhysd/vim-clang-format')
        endif
        call dein#add('vim-jp/cpp-vim')
        " }}}

        " Go lang {{{
        if executable('go')
            call dein#add('fatih/vim-go')
        endif
        " }}}

        " Rust {{{
        if executable('rustc')
            call dein#add('rust-lang/rust.vim')
            call dein#add('racer-rust/vim-racer')
        endif
        " }}}

        " Markdown {{{
        call dein#add('junegunn/vader.vim')
        call dein#add('godlygeek/tabular')
        call dein#add('joker1007/vim-markdown-quote-syntax')
        call dein#add('rcmdnk/vim-markdown')
        " }}}

        " extra tool {{{
        call dein#add('vim-scripts/sudo.vim')
        if executable('ctags')
            call dein#add('soramugi/auto-ctags.vim')
        endif
        if executable('global')
            call dein#add('vim-scripts/gtags.vim')
        endif
        call dein#add('majutsushi/tagbar')

        " call dein#add('scrooloose/nerdtree')
        " call dein#add('airblade/vim-gitgutter')

        " call dein#add('thinca/vim-scouter')

        " call dein#add('itchyny/vim-parenmatch')
        " call dein#add('itchyny/vim-cursorword')

        " call dein#add('nathanaelkane/vim-indent-guides')
        " call dein#add('Yggdroot/indentLine')
        " }}}

        call dein#end()
        call dein#save_state()
    endif

    if dein#check_install()
        call dein#install()
    endif
endif

syntax enable

" 全角スペースを強調表示する
augroup highlightZenkaku
    autocmd!
    autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

set t_Co=256
if s:dein_enabled
    " colorscheme badwolf
    " colorscheme dracula

    let g:alduin_Shout_Become_Ethereal = 1
    colorscheme alduin

    " colorscheme gruvbox
    " let g:gruvbox_contrast_light = 'hard'
else
    colorscheme desert
endif

" includeに飛ぶ
set path=.,$HOME/local/include,/usr/include

set vb t_vb=
set shortmess+=I                      " 起動時のメッセージを消す
let g:bufferline_echo=0               " 変な表示を消す
set hidden                            " 保存されていなくても別のファイルを開く
set nobackup                          " バックアップを作らない
set noswapfile                        " swapファイルを作らない
set autoread                          " 他で書き換えられたら自動で読み直す
set cindent                           " 賢いインデント調整
set ruler                             " 行番号と列番号を表示
set showcmd                           " コマンドを表示
set notitle                           " Thanks for flying Vim
set number                            " 行番号表示
set ignorecase                        " 大文字小文字を無視して検索
set smartcase                         " 大文字を入力すると大文字小文字無視を解除
set wrapscan                          " 先頭に戻って検索
set hlsearch                          " 前回の検索結果が残ってればハイライトする
set incsearch                         " インクリメンタルサーチ
set textwidth=0                       " 自動改行させない
set backspace=indent,eol,start        " バックスペース有効化
set formatoptions+=m                  " 整形オプション，マルチバイト系を追加
set formatoptions-=ro                 " 挿入モードで改行した時に # を自動挿入しない
set wildmenu                          " コマンド補完を強化
set wildmode=list:full                " リスト表示，最長マッチ
set fileformats=unix,dos,mac          " 改行コードの自動認識
set expandtab                         " ソフトTabの有効化
set tabstop=4                         " タブの長さ
set softtabstop=4                     " カーソルが動く幅を調整
set shiftwidth=4                      " 自動インデントの調整
if v:version >= 800
    set breakindent                   " 改行時のインデントを良い感じにする
endif
set scrolloff=10                      " 指定行分だけ余裕を持ってスクロール
set list                              " タブなどの制御文字を表示
set lcs=tab:>.,trail:_,extends:\      " タブを表示する。改行文字は表示しない(listchars)
set laststatus=2                      " 常にステータス行を表示
set showtabline=2                     " 常にタブラインを表示
set ambiwidth=double                  " 全角の変な文字をきれいにする
set display=lastline                  " 長い行でも省略せずに全部表示
set pumheight=10                      " 補完とかのポップアップの高さ
if has('gui')
    set clipboard=unnamed,unnamedplus " クリップボード
endif
set cursorline                        " カーソルラインをハイライト
hi clear CursorLine                   " 行番号だけをハイライトする
if has('conceal')
    set conceallevel=0
    set concealcursor=
endif

highlight Normal ctermbg    = none
highlight Comment ctermfg   = 7
highlight Pmenu ctermbg     = 4
highlight PmenuSel ctermbg  = 1
highlight PMenuSbar ctermbg = 4

" マウスで弄る(使いづらいし、マウスは邪道なので消す)
" if has('mouse')
"     set mouse=a
"     if has('mouse_sgr')
"         set ttymouse=sgr
"     elseif v:version > 703 || v:version is 703 && has('patch632')
"         set ttymouse=sgr
"     else
"         set ttymouse=xterm2
"     endif
" endif

" 良い感じにペーストする
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" deinが無効だったら以下のプラギン設定は全て無視する
" Plugins Configure {{{
if s:dein_enabled
    " path {{{
    let s:php_dict_path  = $HOME . '/.vim/dict/php.dict'
    let s:phpmanual_path = $HOME . '/.vim/ref/php-chunked-xhtml'

    let s:rustfmt_path   = $HOME . '/.cargo/bin/rustfmt'
    let s:racer_path     = $HOME . '/.cargo/bin/racer'
    " let s:rust_src_path  = $HOME . '/local/src/rustc-1.10.0/src'
    " }}}

    " lightline {{{
    let g:lightline =
    \    {
    \        'colorscheme': 'wombat',
    \
    \        'active':
    \        {
    \            'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified', 'fugitive'], ['anzu'] ],
    \            'right': [ ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'] ]
    \        },
    \
    \        'component_function':
    \        {
    \            'modified'    : 'LightLineModified',
    \            'readonly'    : 'LightLineReadonly',
    \            'filename'    : 'LightLineFilename',
    \            'fileformat'  : 'LightLineFileformat',
    \            'filetype'    : 'LightLineFiletype',
    \            'fileencoding': 'LightLineFileencoding',
    \            'mode'        : 'LightLineMode',
    \            'anzu'        : 'anzu#search_status',
    \            'fugitive'    : 'fugitive#head'
    \        },
    \    }

    let g:lightline.tabline =
    \    {
    \        'left': [ ['tabs'] ],
    \        'right': []
    \    }

    function! LightLineModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! LightLineReadonly()
        return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
    endfunction

    function! LightLineFilename()
        return (LightLineReadonly() != '' ? LightLineReadonly() . ' '  : '') .
        \      (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \      &ft == 'unite' ? unite#get_status_string() :
        \      &ft == 'vimshell' ? vimshell#get_status_string() :
        \      expand('%:t') != '' ? expand('%:t') : '[No Name]') .
        \      (LightLineModified() != '' ? ' ' . LightLineModified() : '')
    endfunction

    function! LightLineFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! LightLineFiletype()
        return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
    endfunction

    function! LightLineFileencoding()
        return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
    endfunction

    function! LightLineMode()
        return &ft == 'unite'    ? 'Unite' :
        \      &ft == 'vimfiler' ? 'VimFiler' :
        \      &ft == 'vimshell' ? 'VimShell' :
        \      winwidth(0) > 60  ? lightline#mode() : ''
    endfunction
    " }}}

    " anzu {{{
    nmap n <Plug>(anzu-n)
    nmap N <Plug>(anzu-N)
    nmap * <Plug>(anzu-star)
    nmap # <Plug>(anzu-sharp)
    augroup vim-anzu
        autocmd!
        autocmd WinLeave,TabLeave * call anzu#clear_search_status()
    augroup END
    " }}}

    if has('lua')
        " NeoComplete {{{
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#enable_underbar_completion = 0
        let g:neocomplete#enable_camel_case_completion  = 0
        let g:neocomplete#max_list = 20
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#auto_completion_start_length = 2
        let g:neocomplete#enable_auto_close_preview = 0
        " let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

        let g:neocomplete#sources#dictionary#dictionaries =
        \    {
        \        'default'  : '',
        \        'php'      : s:php_dict_path
        \    }

        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        inoremap <expr><C-g> neocomplete#undo_completion()
        inoremap <expr><C-l> neocomplete#complete_common_string()

        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
        endfunction

        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> neocomplete#close_popup()
        inoremap <expr><C-e> neocomplete#cancel_popup()
        " }}}
    else
        " neocomplcache {{{
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_min_syntax_length = 3
        " let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

        let g:neocomplcache_dictionary_filetype_lists =
        \    {
        \        'default'  : '',
        \        'php'      : s:php_dict_path
        \    }

        inoremap <expr><C-g> neocomplcache#undo_completion()
        inoremap <expr><C-l> neocomplcache#complete_common_string()

        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return neocomplcache#smart_close_popup() . "\<CR>"
        endfunction

        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

        inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS>   neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()
        " }}}
    endif

    " for vim-clang {{{
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
        let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
        let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    endif
    " }}}

    autocmd FileType html,markdown,tpl setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css               setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType javascript        setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd filetype xml               setlocal omnifunc=xmlcomplete#completetags

    " Snippet {{{
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    let g:neosnippet#enable_snipmate_compatibility = 1
    " クソ重いのでコメントアウト（標準のみ使う）
    " let g:neosnippet#snippets_directory='~/.vim/snippets/'
    " }}}

    " vim-clang {{{
    let g:clang_auto = 0

    let g:clang_c_completeopt = 'menuone,preview'
    let g:clang_cpp_completeopt = 'menuone,preview'

    " let g:clang_format_auto = 1
    " let g:clang_check_syntax_auto = 0

    let g:clang_c_options = '-std=c11'
    let g:clang_cpp_options = '-std=c++1z -stdlib=libc++ --pedantic-errors'
    let g:clang_format_style = 'Google'

    autocmd BufWrite,FileWritePre,FileAppendPre *.[ch]pp call ClangFormat()
    " }}}

    " quickrun {{{
    let g:quickrun_config = get(g:, 'quickrun_config', {})
    " 成功したらバッファ、失敗したらquickfixで表示
    let g:quickrun_config._ = {
    \    'runner'                          : 'vimproc',
    \    'runner/vimproc/updatetime'       : 60,
    \    'outputter'                       : 'error',
    \    'outputter/error/success'         : 'buffer',
    \    'outputter/error/error'           : 'quickfix',
    \    'outputter/buffer/split'          : ':rightbelow 20',
    \    'outputter/buffer/close_on_empty' : 1,
    \}
    " }}}

    " syntax-check {{{
    " let g:syntastic_always_populate_loc_list = 1
    " let g:syntastic_auto_loc_list = 1
    " let g:syntastic_check_on_open = 1
    " let g:syntastic_check_on_wq = 0
    " let g:syntastic_php_checkers = ['php']
    " let g:syntastic_javascript_checkers = ['jshint']
    " let g:syntastic_scss_checkers = ['scss_lint']
    " let g:syntastic_loc_list_height = 5

    " au BufRead,BufNewFile *.php set makeprg=php\ -l\ %
    " au BufRead,BufNewFile *.php set errorformat=%m\ in\ %f\ on\ line\ %l
    " autocmd FileType php map <c-c><c-c> :make<cr> :cw<cr><cr>

    " watchdogs
    let g:watchdogs_check_BufWritePost_enable = 1
    " let g:watchdogs_check_CursorHold_enable = 1
    call watchdogs#setup(g:quickrun_config)

    let php_sql_query = 1
    let php_baselib = 1
    let php_htmlInStrings = 1
    let php_noShortTags = 1
    let php_folding = 0
    let php_parent_error_close = 1
    let php_parent_error_open = 1

    let g:php_cs_fixer_rules = '@PSR2'
    let g:php_cs_fixer_php_path = 'php'
    let g:php_cs_fixer_enable_default_mapping = 1
    let g:php_cs_fixer_dry_run = 0
    let g:php_cs_fixer_verbose = 0
    nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

    " let g:phpfmt_standard = 'PSR2'
    " let g:phpfmt_autosave = 1
    " let g:phpfmt_command = $HOME . '/.composer/vendor/bin/phpcbf'

    " for JSX
    let g:jsx_ext_required = 0
    " }}}

    " Unite {{{
    let g:unite_enable_start_insert = 1
    let g:unite_winheight = 20

    noremap <C-B> :Unite buffer<CR>
    noremap <C-N> :Unite -buffer-name=file file<CR>
    noremap <C-Z> :Unite file_mru<CR>
    noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>

    " au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
    " au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
    " au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
    " au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
    au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

    nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
    nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
    " }}}

    " using ag {{{
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''

    let g:ctrlp_user_command = 'ag %s -l'
    " }}}

    " NERDTreeToggle {{{
    " nnoremap <silent><C-e> :NERDTreeToggle<CR>
    " }}}

    " php Reference {{{
    let g:ref_phpmanual_cmd = 'lynx -dump %s'
    let g:ref_source_webdict_cmd = 'lynx -dump %s'
    let g:ref_phpmanual_path = s:phpmanual_path

    " webdict設定
    let g:ref_source_webdict_sites =
    \    {
    \        'je': {
    \            'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
    \        },
    \        'ej': {
    \            'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
    \        },
    \        'wiki': {
    \            'url': 'https://ja.wikipedia.org/wiki/%s',
    \        },
    \    }
    let g:ref_source_webdict_sites.default = 'ej'

    function! g:ref_source_webdict_sites.je.filter(output)
        return join(split(a:output, "\n")[15 :], "\n")
    endfunction
    function! g:ref_source_webdict_sites.ej.filter(output)
        return join(split(a:output, "\n")[15 :], "\n")
    endfunction
    function! g:ref_source_webdict_sites.wiki.filter(output)
        return join(split(a:output, "\n")[17 :], "\n")
    endfunction

    nnoremap <Leader>re :<C-u>Ref webdict ej<Space>
    nnoremap <Leader>rj :<C-u>Ref webdict je<Space>
    nnoremap <Leader>rw :<C-u>Ref webdict wiki<Space>

    autocmd FileType ref-* nnoremap <buffer> <silent> q :<C-u>close<CR>
    " }}}

    " VimShell {{{
    let g:vimshell_prompt = 'vimshell% '
    " }}}

    " ctags {{{
    let g:auto_ctags = 0
    let g:auto_ctags_tags_args = '--append=yes --recurse=yes --sort=yes --languages=PHP,C,C++'
    if executable('ctags')
        nnoremap <F3> :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

        nnoremap <F8> :TagbarToggle<CR>
    endif
    " }}}

    " gtags {{{
    if executable('global')
        nnoremap <C-f> :Gtags -f %<CR>
        nnoremap <C-j> :GtagsCursor<CR>
    endif
    " }}}

    " インデント可視化 {{{
    " let g:indent_guides_enable_on_vim_startup = 1
    " let g:indent_guides_start_level = 4
    " let g:indent_guides_guide_size = 1
    " let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']
    " let g:indentLine_faster = 1
    " }}}

    " Rust {{{
    let g:rustfmt_autosave = 1
    let g:rustfmt_command = s:rustfmt_path
    " racer使うときは以下必須(既にsetしているのでコメントアウト)
    " set hidden
    let g:racer_cmd = s:racer_path
    " 事前に環境変数にぶち込んでおく
    " let $RUST_SRC_PATH = s:rust_src_path
    " }}}

    " vim-jsonでシンタックス上書き(jsonのダブルクオーテーション表示)
    let g:vim_json_syntax_conceal = 0
endif
" }}} プラギン設定ここまで

augroup indentgroup
    autocmd!
    " vim-scripts/smarty-syntax が絶望的に重いのでHTMLで代用
    autocmd BufRead,BufNewFile *.tpl setlocal filetype=html
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html
    autocmd BufRead,BufNewFile *.scss setlocal filetype=css

    " フロントのインデント
    autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType vue        setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType html       setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd FileType css        setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" 自動で閉じ括弧付けるのはウザいのでエンターで閉じさせる
inoremap {<Enter> {}<LEFT>
inoremap [<Enter> []<LEFT>
inoremap (<Enter> ()<LEFT>
inoremap "<Enter> ""<LEFT>
inoremap '<Enter> ''<LEFT>

" 始点から行末までをまとめてヤンク
nnoremap Y y$

" 検索単語を画面中央に
" anzuと競合するところはコメントアウト
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" タブでペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" ハイライト消す
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> <C-c><C-c> :nohlsearch<CR>

" 保存時に各行末の空白を除去
function! s:remove_dust()
    let cursor = getpos('.')
    %s/\s\+$//ge
    call setpos('.', cursor)
    unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()

" vimgrepの結果は常にQuickFixで開く
augroup grepopen
    autocmd!
    autocmd QuickfixCmdPost vimgrep cw
augroup END

" カーソル位置を記憶する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif

filetype plugin indent on
