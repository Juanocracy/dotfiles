#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#Para que abra automaticamente NVim
#nvim
#Agregar Starship
eval "$(starship init bash)"

bind "set completion-ignore-case on"
