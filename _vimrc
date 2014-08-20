"=================================================
" NeoBundle
"=================================================

" NeoBundle がインストールされていない時、
" もしくは、プラグインの初期化に失敗した時の処理
function! s:WithoutBundles()
  colorscheme desert
  " その他の処理
endfunction

" NeoBundle よるプラグインのロードと各プラグインの初期化
function! s:LoadBundles()
  " 読み込むプラグインの指定
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/vimproc.vim'
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'
  
  "- カラースキーム
  NeoBundle 'tomasr/molokai'
  NeoBundle 'nanotech/jellybeans.vim'
  NeoBundle 'ujihisa/unite-colorscheme'
  
  "- 整形(まとめて''等を入れたり消せたり)
  NeoBundle 'tpope/vim-surround'

  "- 置換する部分をハイライトで表示する
  NeoBundle 'osyo-manga/vim-over.git'

  "- 起動時にどのファイルを開くか選択できる
  NeoBundle 'mhinz/vim-startify'

  "- 関数定義の一覧表示
  NeoBundle 'h1mesuke/unite-outline'
  
  "- 履歴
  NeoBundle 'thinca/vim-unite-history'
  
  " 翻訳プラグインに必要
  NeoBundle 'mattn/webapi-vim'
  NeoBundle 'mattn/excitetranslate-vim' 
  
  "- 整形
  NeoBundle 'vim-scripts/Align'

  " 読み込んだプラグインの設定

  "- Unite.vimの設定
  let g:unite_enable_start_insert=1
  let g:unite_source_history_yank_enable=1

  "- neocompleteの設定(補完プラグイン)
  "-- 起動時に有効化
  let g:neocomplete#enable_at_startup = 1
  "-- 
  let g:neocomplete#enable_ignore_case = 1
  "-- SmartCase機能の有効化(大文字が入力されるまで、小文字との区別無視)
  let g:neocomplete#enable_smart_case = 1
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'

  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

  "- neosnippetの設定(スニペット)




endfunction

" NeoBundle がインストールされているなら LoadBundles() を呼び出す
" そうでないなら WithoutBundles() を呼び出す
function! s:InitNeoBundle()
  if isdirectory(expand("~/vim/bundle/auto/neobundle.vim/"))
    filetype plugin indent off
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/auto/neobundle.vim/
    endif
    try
      call neobundle#rc(expand('~/vim/bundle/auto/'))
      call s:LoadBundles()
    catch
      call s:WithoutBundles()
    endtry 
  else
    call s:WithoutBundles()
  endif

  filetype indent plugin on
  syntax on
endfunction

call s:InitNeoBundle()



"=================================================
" KeyMapping
" nnoremap -> ノーマルモード
" cnoremap -> コマンドラインモード
" inoremap -> インサートモード
" <CR> -> 改行
" <Nop> -> 何もしない(無効化)
"=================================================

" _vimrcの呼び出し
nnoremap <Space>ev :e $HOME/vim/_vimrc<CR>

" _vimrcの再呼び出し
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC<CR>

" _gvimrcの呼び出し
nnoremap <Space>eg :e $HOME/vim/_gvimrc<CR>

" _gcimrcの再呼び出し"
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

" Myコマンドリストの呼び出し
nnoremap <Space>ec :e $HOME/vim/VimCommandList.txt<CR>

" アルゴリズム構造の呼び出し
nnoremap <Space>ea :e $HOME/Desktop/アルゴリズム構造.txt<CR>

" 個人的ゲームメモの呼び出し
nnoremap <Space>em :e $HOME/Desktop/個人的ゲームメモ.txt<CR>

" 『;』『:』をチェンジ
nnoremap ; : 
nnoremap : ;

" エンターを押すと改行
nnoremap <CR> i<CR><ESC>

" Ctrl+sで上書き保存
nnoremap <C-s> :w<CR>

" Space+hで行頭(空白じゃない)へ飛ぶ
nnoremap <Space>h ^

" Space+lで行末へ飛ぶ
nnoremap <Space>l $

" 行末まで削除
nmap dl d$

" x(削除)でyankに入らないようにする
nnoremap x i<Del><ESC>l

" 新しいタブ
nnoremap tt :tabnew<CR>

" ファイルを閉じる
nnoremap qq :q<CR>

" Ctrl+gtで前タブ
noremap <C-G><C-T> gT

" Ctrl+Shift+でウィンドウ調整(分割時)
noremap <C-Left> <C-W><
noremap <C-Right> <C-W>>
noremap <C-Up> <C-W>+
noremap <C-Down> <C-W>-

" Exモードへの誤爆阻止
nnoremap Q <Nop>

" ハイライトの色を消す
nnoremap <ESC><ESC> :nohlsearch<CR>

" Ctrl+操作キーでウィンドウ移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" カンマを押したあと、空白をつける
inoremap , ,<Space>

" Speceを使ったUnite.vimの設定
nnoremap [unite] <Nop>
nmap <Space>u [unite]

" vimgrep使用時、検索結果移動系
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap [Q :<C-u>clast<CR>

"- ファイル一覧開く
nnoremap <silent> [unite]f :Unite file<CR>
"- バッファ一覧開く
nnoremap <silent> [unite]b :Unite buffer<CR>
"- レジスタ一覧
nnoremap <silent> [unite]r :Unite register<CR>
"- Unite-outline起動
nnoremap <silent> [unite]o :Unite outline<CR>

"- ESC2回でUntieモードを終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

autocmd FileType unite call s:Unite_my_settings()

"- Unite.vim操作中
function! s:Unite_my_settings()"{{{
	"ESCでuniteを終了
	nmap <buffer> <ESC> <Plug>(unite_exit)
	"入力モードのときjjでノーマルモードに移動
	imap <buffer> jj <Plug>(unite_insert_leave)
	"入力モードのときctrl+wでバックスラッシュも削除
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	"ctrl+jで縦に分割して開く
	nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	"ctrl+lで横に分割して開く
	nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
	inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
	"ctrl+oでその場所に開く
	nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')

endfunction"}}}

" vim-overの起動(置換プラグイン)
nnoremap <silent> <Space>o :OverCommandLine<CR>%s/

" Excitetranslate-vim要するに翻訳プラグインのマッピング
nnoremap <silent> tr :<C-u>ExciteTranslate<CR>

" インサートモードにてカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Ctrl+gでインサートモード解除
inoremap <C-g> <ESC>

" 引用符の自動入力&移動
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap < <><Left>

" ビジュアルモードでvで行末まで選択
vnoremap v $h

" ビジュアルモードで選択範囲を検索
vnoremap * "zy:let @/ = @z<CR>n


" タブインデントの4と2の切替
function! s:Toggle_indent()
  if &tabstop == 2
    setlocal shiftwidth=4
    setlocal tabstop=4
    setlocal softtabstop=4
  else
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=2
  endif
endfunction

nnoremap <silent> <Space><TAB> :<C-u>call <SID>Toggle_indent()<CR>
 
" タブの場所移動
function! s:MoveTabpage(num)
  if type(a:num) != type(0)
    return
  endif

  let pos = tabpagenr() -1 + a:num
  let tabcount = tabpagenr("$")

  if pos < 0
    let pos = tabcount -1
  elseif pos >= tabcount
    let pos = 0
  endif

  execute "tabmove" . pos
endfunction

command! -nargs=1 TabMove :call <SID>MoveTabpage(<f-args>)

nnoremap <C-S-Right> :call <SID>MoveTabpage(1)<Return>
nnoremap <C-S-Left>  :call <SID>MoveTabpage(-1)<Return>


" コメントドキュメントの作成
function! s:Comment_Document()
  call append(line("."), "/**")
  call append(line(".")+1,  "* ")
  call append(line(".")+2,  "*/")
  call cursor(line(".")+2, line(".")+2)
endfunction

inoremap <silent> /** <ESC>:<C-u>call <SID>Comment_Document()<CR>a



"=================================================
" Set
"=================================================

set nocompatible

" ツールバーを削除
set guioptions-=T

"メニューを削除
set guioptions-=m

" カーソル移動関連の設定
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

" ファイル処理関連の設定
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

" 検索/置換の設定
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする

" タブ/インデントの設定
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=4	  " 画面上でタブ文字が占める幅
set shiftwidth=4  " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
 
" 動作環境との統合関連の設定

" OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamed,unnamedplus
" マウスの入力を受け付ける
set mouse=a
" Windows でもパスの区切り文字を / にする
set shellslash
" インサートモードから抜けると自動的にIMEをオフにする
set iminsert=2

" コマンドラインの設定

" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を10000件保存する
set history=10000

" ビープの設定

"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない


"=================================================
" autocmd
"=================================================
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END




