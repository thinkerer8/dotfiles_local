HISTFILE=$HOME/.zsh-history # 履歴の保存先
HISTSIZE=100000 # メモリに展開する履歴の数 
SAVEHIST=100000 # 保存する履歴の数
setopt share_history # 同一ホストで動いているzshで履歴を共有

autoload -U compinit 
compinit
autoload colors
colors

# prompt
#

# PROMPT=$BLUE'[${USER}@${HOST}] %(!.#.$) '$WHITE
# RPROMPT=$GREEN'[%~]'$WHITE

PROMPT="%{${fg[white]}%}[%n@%m]#%{${reset_color}%}"
RPROMPT="%{${fg[white]}%}[%d]%{${reset_color}%"
#RPROMPT="[%d]"

# case ${UID} in
# 0)
#     PROMPT="%B%{${fg[white]}%}%/#%{${reset_color}%}%b "
#     PROMPT2="%B%{${fg[white]}%}%_#%{${reset_color}%}%b "
#     SPROMPT="%B%{${fg[white]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#         PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#     ;;
# *)
#     PROMPT="%{${fg[white]}%}%/%%%{${reset_color}%} "
#     PROMPT2="%{${fg[white]}%}%_%%%{${reset_color}%} "
#     SPROMPT="%{${fg[white]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#     [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#         PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
#     ;;
# esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
#    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

setopt auto_pushd

zstyle ':completion:*:default' menu select=1

setopt correct

alias pull="ruby /Users/mkinuhar/Documents/AS/programing/ruby/script_for_lab_work/pull_show_result.rb"
alias ls="ls -GF"

export LS_COLORS='di=01;36'
export PATH=$PATH:/usr/local/mysql/bin