HISTSIZE=200 HISTFILE=~/.zhistory SAVEHIST=180
PROMPT='%B%F{green}%n@%M:%f%F{blue}%~%f `vcs_echo`%b
%# '
RPROMPT='%B%F{magenta}[%*]%f%b'

autoload -U compinit && compinit
autoload -U colors && colors
autoload -U vcs_info

export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

setopt auto_cd auto_remove_slash auto_name_dirs
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups
setopt print_eight_bit
# setopt auto_menu  correct rm_star_silent sun_keyboard_hack
# setopt share_history inc_append_history

alias copy='cp -ip' del='rm -i' move='mv -i'
alias fullreset='echo "\ec\ec"'
h () {history $* | less}
alias ja='LANG=ja_JP.eucJP XMODIFIERS=@im=kinput2'
alias ls='ls -F' la='ls -a' ll='ls -la' lr='ls -ltr'
mdcd () {mkdir -p "$@" && cd "$*[-1]"}
mdpu () {mkdir -p "$@" && pushd "$*[-1]"}
alias pu=pushd po=popd dirs='dirs -v'
alias ssh='TERM=xterm ssh'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Suffix Aliases
# alias -s pdf=acroread dvi=xdvi
# alias -s {odt,ods,odp,doc,xls,ppt}=soffice
# alias -s {tgz,lzh,zip,arc}=file-roller

# binding keys
bindkey -e
# bindkey '^p' history-beginning-search-backward
# bindkey '^n' history-beginning-search-forward

# completion
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# display Git branch-name
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' actionformats '%b'
vcs_echo() {
    local color
    STY= LANG=en_US.UTF-8 vcs_info
    color=${fg[red]}
    echo -n "%{$color%}$(git name-rev --name-only HEAD 2> /dev/null)%{$reset_color%}"
}
