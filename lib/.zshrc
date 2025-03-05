# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/luck/.zsh/completions:"* ]]; then export FPATH="/home/luck/.zsh/completions:$FPATH"; fi
#!/usr/bin/zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export DOTFILES=$HOME/.dotfiles/lib/zsh
export PATH=$PATH:"/mnt/c/Users/Luck/AppData/Local/Programs/Microsoft VS Code/bin/":/usr/local/go/bin

source $DOTFILES/oh-my-zsh.sh
source $DOTFILES/plugins/init.sh
# source $DOTFILES/filetype/init.sh
source $DOTFILES/aliases.sh
source $DOTFILES/settings.sh

# Avoid TMUX recursion
if [ "$TMUX" = "" ]; then tmux; fi

. "/home/luck/.deno/env"