# Start starship
source <(starship init zsh --print-full-init);
# Start direnv
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)";
# Configure bindings for history search
bindkey '^[[A' history-substring-search-up;
bindkey '^[[B' history-substring-search-down;
# Set auto cd
setopt auto_cd;
# Open tmux automatically
if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi
function realpath() {
    echo `pwd`/"$1"
}
