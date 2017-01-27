typeset -U path
setopt no_beep
bindkey -e

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit && compinit

# モジュール読み込み
zmodload zsh/datetime
zmodload zsh/mathfunc
#zmodload zsh/files
zmodload zsh/stat
zmodload zsh/system
zmodload zsh/net/tcp
zmodload zsh/zftp
zmodload zsh/zprof
zmodload zsh/zpty

# 色々
autoload -Uz colors && colors
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'
autoload -Uz vcs_info
autoload -Uz is-at-least

# ヒストリー
setopt append_history extended_history hist_ignore_all_dups hist_ignore_space hist_no_store
HISTFILE=~/.zhistory
HISTSIZE=200
SAVEHIST=180

# ディレクトリ関連
setopt auto_cd auto_pushd pushd_ignore_dups auto_name_dirs

# 補完
# 補完オプション
setopt always_last_prompt complete_in_word auto_list auto_menu
setopt auto_param_keys auto_param_slash auto_remove_slash extended_glob
setopt complete_aliases glob_complete hash_list_all list_ambiguous list_types rec_exact

# 一覧表示グループ化
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%BCompleting %d%b'

# vimとかで同じファイルを指定しないようにさせる
zstyle ':completion:*:(vi|vim|cp|mv|rm|less):*' ignore-line true

# configureのヘルプを良い感じに補完する
function configure-help() {
    grep -- '^[ \t]*--[A-Za-z]' ${~words[1]} | egrep -v '\[|\]'
}
zstyle ':completion:*:configure:*:options' command configure-help

# コンプリータ
zstyle ':completion:*' completer _complete _approximate _correct_filename _prefix _match _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# エイリアス
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias copy='cp -ip'
alias del='rm -i'
alias move='mv -i'
alias la='ls -a'
alias ll='ls -la'
alias lr='ls -ltr'
alias df='df -h'
alias ps='ps --sort=start_time'
alias ssh='TERM=xterm ssh'

# Gitのブランチ名をプロンプトに表示させる
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' max-exports 6
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' actionformats '%b|%a'
if is-at-least 4.3.10; then
    #zstyle ':vcs_info:git:*' check-for-changes true
    #zstyle ':vcs_info:git:*' stagedstr '+'
    #zstyle ':vcs_info:git:*' unstagedstr '?'
    #zstyle ':vcs_info:git:*' formats '%b' '%c' '%u'
    #zstyle ':vcs_info:git:*' actionformats '%b|%a' '%c' '%u'
fi
function echo_branch () {
    local branch
    STY= LANG=en_US.UTF-8 vcs_info
    if [[ -n "$vcs_info_msg_0_" ]]; then
        branch="$vcs_info_msg_0_"
        if [[ -n "$vcs_info_msg_1_" ]]; then
            # staged
            branch="%F{red}($branch)%f%F{green}[+]%f"
        elif [[ -n "$vcs_info_msg_2_" ]]; then
            # unstaged
            branch="%F{red}($branch)%f%F{yellow}[?]%f"
        else
            branch="%F{red}($branch)%f"
        fi
        print -n "$branch"
    fi
}

# プロンプト
setopt prompt_subst
PROMPT='%B%F{green}%n@%M:%f%F{blue}%~%f `echo_branch`%b
%# '
RPROMPT='%B%F{magenta}[%*]%f%b'
