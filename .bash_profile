eval "$(/opt/homebrew/bin/brew shellenv)"

export XDG_CONFIG_HOME="$HOME"/.config

if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi
