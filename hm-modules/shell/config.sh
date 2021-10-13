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

# Enable unicode symbols in tmux
# https://askubuntu.com/questions/410048/utf-8-character-not-showing-properly-in-tmux
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Fix issue with tab-completion duplicating commands
# https://github.com/ohmyzsh/ohmyzsh/issues/5157
export LC_CTYPE=en_US.UTF-8

# Open tmux automatically
if [ -z "$TMUX" ]
then
    tmux attach -t TMUX || tmux new -s TMUX
fi
function realpath() {
    echo `pwd`/"$1"
}
