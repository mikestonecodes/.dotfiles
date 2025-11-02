#!/usr/bin/env fish
# Export bun paths
set -U fish_user_paths $HOME/go/bin $fish_user_paths
set -U fish_greeting
starship init fish | source
zoxide init fish | source
alias dotfiles 'git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
bind \e\[C 'commandline -f forward-char'
bind \e 'commandline -f forward-char'
set -x BROWSER helium-browser
set -x SYSTEMD_EDITOR nvim
source ~/.config/fish/keys.fish

fish_add_path $HOME/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#exec ~./hyprland.fish
