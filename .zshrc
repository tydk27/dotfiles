# zplug
if [ -d ~/.zplug ]; then
    source ~/.zplug/init.zsh

    zplug 'yous/vanilli.sh'                            # バニラなzsh
    zplug 'zsh-users/zsh-autosuggestions'              # 候補デフォルト表示
    zplug 'zsh-users/zsh-completions'                  # 補完強化
    zplug 'zsh-users/zsh-syntax-highlighting', defer:2 # zshシンタックスハイライト
    zplug 'mollifier/anyframe'                         # pecopecoharapeko
    zplug 'mollifier/cd-gitroot'                       # gitのルートディレクトリに移動
    # zplug 'dracula/zsh', as:theme

    # if ! zplug check --verbose; then
    #     printf 'Install? [y/N]: '
    #     if read -q; then
    #         echo; zplug install
    #     fi
    # fi
    zplug check || zplug install

    # zplug load --verbose
    zplug load
fi

zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit && compinit
autoload -Uz colors && colors
autoload -Uz vcs_info chpwd_recent_dirs cdr add-zsh-hook is-at-least
if is-at-least 4.3.10; then
    add-zsh-hook chpwd chpwd_recent_dirs
fi

# 色々
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

if [ -x /usr/local/bin/dircolors ] && [ `eval uname` = 'FreeBSD' ]; then
    export LSCOLORS=ExGxdxdxCxDxDxBxBxegeg
    alias ls='ls -G'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
elif [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
fi


# Gitのブランチ名をプロンプトに表示させる
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' max-exports 6
zstyle ':vcs_info:git:*' formats "%F{red}(%b)%f"
zstyle ':vcs_info:git:*' actionformats '%b|%a'
if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' formats "%F{red}(%b)%f%c%u"
    zstyle ':vcs_info:git:*' stagedstr "%F{green}[+]%f"
    zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}[!]%f"
fi
function echo_branch () {
    STY= LANG=en_US.UTF-8 vcs_info
    if [[ -n "$vcs_info_msg_0_" ]]; then
        print -n "$vcs_info_msg_0_"
    fi
}

# PROMPT='%B%F{green}%n@%M:%f%F{blue}%~%f `echo_branch`%b
# %# '
# RPROMPT='%B%F{magenta}[%*]%f%b'

# 上記の設定だと目が痛くなるのでちょっと暗めにする
P_NAME="%{[38;5;028m%}"
P_PATH="%{[38;5;068m%}"
P_DATE="%{[38;5;127m%}"
COLOR_END="%{[0m%}"
PROMPT='%B${P_NAME}%n@%M:${COLOR_END}${P_PATH}%~${COLOR_END} `echo_branch`%b
%# '
RPROMPT='%B${P_DATE}[%*]${COLOR_END}%b'

# モジュール読み込み
zmodload zsh/datetime       # strftime関数やEPOCHSECONDS環境変数が使える
zmodload zsh/mathfunc       # Cのような数式評価が使える
# zmodload zsh/example      # モジュール作成用サンプル
zmodload zsh/files          # 一部の標準コマンドを独自用法で使う
zmodload zsh/stat           # stat値を取得表示
zmodload zsh/system         # syserror sysread syswrite
zmodload zsh/zprof          # シェル関数プロファイリング

# エイリアス
alias copy='cp -ip'
alias del='rm -i'
alias move='mv -i'
alias la='ls -a'
alias ll='ls -la'
alias lr='ls -ltr'
alias df='df -h'
alias ps='ps --sort=start_time'
alias ssh='TERM=xterm ssh'
alias cdg='cd-gitroot'

# その他オプション
typeset -U path             # PATHをユニークにする
bindkey -e                  # emacsキーバインド
setopt no_beep              # beep音なし
setopt prompt_subst         # プロンプト

# ヒストリー
HISTFILE=~/.zhistory
HISTSIZE=200
SAVEHIST=180
setopt append_history       # ヒストリファイルに追記
setopt extended_history     # ヒストリを拡張フォーマットで保存
setopt hist_ignore_all_dups # 同一コマンドは保存しない
setopt hist_ignore_space    # 先頭スペースのコマンドは保存しない
setopt hist_no_store        # ヒストリ参照コマンドは保存しない

# ディレクトリ関連
setopt auto_cd              # cd省略
setopt auto_pushd           # 元ディレクトリをスタックにプッシュ
setopt pushd_ignore_dups    # 同じディレクトリはプッシュしない

# 補完
# 補完オプション
setopt always_last_prompt   # プロンプトの再生成禁止
setopt complete_in_word     # カーソル位置で補完可に
setopt auto_list            # 自動で一覧表示
setopt auto_menu            # 自動でメニュー補完
setopt auto_param_keys      # 閉じ括弧でカンマなどを消す
setopt auto_param_slash     # ディレクトリなら自動でスラッシュ付与
setopt auto_remove_slash    # 自動スラッシュをデリミタ入力で削除
setopt complete_aliases     # 補完時にエイリアスを置き換えない
setopt extended_glob        # グロッビングフラグ
setopt glob_complete        # グロッビング補完
setopt hash_list_all        # コマンド補完でハッシュチェック
setopt list_types           # 一覧のファイル末尾に種別表示
setopt rec_exact            # 完全一致なら確定

# 一覧表示グループ化とdesc表示フォーマット
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%BCompleting %d%b'
# vimはメニュー選択モード
zstyle ':completion:*:vim:*' menu true select
# pingのhostsを指定
zstyle ':completion:*:ping:*' hosts www.google.com
# vimとかで同じファイルを指定しないようにさせる
zstyle ':completion:*:(vi|vim|cp|mv|rm|less):*' ignore-line true
# _match:globパターンを含む補完選別
zstyle ':completion:*' completer _complete _match _ignored
# 小文字大文字どちらでも補完可
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} m:{A-Z}={a-z}'
# 候補一覧の色分けをLS_COLORSで表示する
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# anyframeバインドキー
bindkey '^xe' anyframe-widget-execute-history
bindkey '^xp' anyframe-widget-put-history
bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^xc' anyframe-widget-checkout-git-branch
bindkey '^xb' anyframe-widget-cdr
bindkey '^xf' anyframe-widget-insert-filename
