" ----------deinセットアップここから----------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" 未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
" ----------deinセットアップここまで----------

" 文字列
" 文字カラー256色対応
set t_Co=256

" カラースキーム
colorscheme iceberg

" ファイル読み込み時の文字コード
set encoding=utf-8

" Vim script内でマルチバイト文字を使う場合の設定
scriptencoding utf-8

" エンコーディング
" 保存時の文字コード
set fileencoding=utf-8

" 読み込み時の文字コードの自動判別. 左側が優先される
set fileencodings=ucs-boms,utf-8,euc-jp,cp932

" 改行コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac

" 構文ハイライトを有効
syntax enable

" キーボード
" インサートモードでのbackspaceを有効
noremap! <C-?> <C-h>

" インサートモードでbackspaceによる改行の削除を可能にする
set backspace=indent,eol,start

" ノーマルモードでの矢印キーでの移動を禁止(以下同じ)
nnoremap <Up>    :q!<CR>
nnoremap <Down>  :q!<CR>
nnoremap <Left>  :q!<CR>
nnoremap <Right> :q!<CR>

" インサートモードでの矢印キーでの移動を禁止(以下同じ)
inoremap <Up>    <ESC>:q!<CR>
inoremap <Down>  <ESC>:q!<CR>
inoremap <Left>  <ESC>:q!<CR>
inoremap <Right> <ESC>:q!<CR>

" タブ入力を複数の空白入力に置き換える
set expandtab

" 画面上でタブ文字が占める幅
set tabstop=4

" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4

" 改行時に前の行のインデントを継続する
set autoindent

" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent

" smartindentで増減する幅
set shiftwidth=4

" カーソル 
" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~

" 行番号を表示
set number

" カーソルラインをハイライト
set cursorline

" 検索
" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch

" 検索パターンに大文字小文字を区別しない
set ignorecase

" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase

" 検索結果をハイライト
set hlsearch
nnoremap <F3> :noh<CR>

" ヤンクした時にクリップボードにコピーする
set clipboard=unnamed,autoselect
