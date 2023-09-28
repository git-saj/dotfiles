# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

# Set to superior editing mode
set -o emacs

# keybinds
bind -x '"\C-l":clear'

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export REPOS="$HOME/repos"
export GITUSER="git-saj"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export BROWSER="wslview"
export ICLOUD="$HOME/icloud"
export SECOND_BRAIN="$HOME/second-brain"
export BASH_SILENCE_DEPRECATION_WARNING=1

PATH="${PATH:+${PATH}:}"$SCRIPTS":"$HOME"/.local/bin"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

clone() {
	local repo="$1" user
	local repo="${repo#https://github.com/}"
	local repo="${repo#git@github.com:}"
	if [[ $repo =~ / ]]; then
		user="${repo%%/*}"
	else
		user="$GITUSER"
		[[ -z "$user" ]] && user="$USER"
	fi
	local name="${repo##*/}"
	local userd="$REPOS/github.com/$user"
	local path="$userd/$name"
	[[ -d "$path" ]] && cd "$path" && return
	mkdir -p "$userd"
	cd "$userd"
	echo gh repo clone "$user/$name" -- --recurse-submodule
	gh repo clone "$user/$name" -- --recurse-submodule
	cd "$name"
} && export -f clone

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~

# TODO: need to add ssh-agent config here

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias vim=nvim

# ls
alias ls='ls --color=auto'
alias ll='ls -la'

# kubectl
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k

# env variables
export VISUAL=nvim
export EDITOR=nvim

# sourcing
source /usr/share/nvm/init-nvm.sh
source "$HOME/.privaterc"

if [[ "$OSTYPE" == "darwin"* ]]; then
	source "$HOME/.fzf.bash"

	# brew bash completion
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
	source /usr/share/fzf/key-bindings.bash
	source /usr/share/fzf/completion.bash
fi
