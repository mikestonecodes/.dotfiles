#!/usr/bin/env fish
# Export bun paths
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -U fish_greeting
starship init fish | source
alias dotfiles 'git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Retrieve the current terminal identifier
set current_tty (tty)

# Check if the current session is a login shell
if status --is-login
    # Ensure we're on tty1
    if test "$current_tty" = "/dev/tty1"
        # Run the Hyprland script directly; check its success or failure
        if ~/hyprland.fish
            echo "goodbye, now logging out"
            exit 0
        else
            echo "hyprland.fish failed"
            echo "refusing autologin without hyprland on tty1"
            exit 1
        end
    end
end
bind \e\[C 'commandline -f forward-char'
bind \e 'commandline -f forward-char'
zoxide init fish | source
set -x LD_LIBRARY_PATH /usr/local/lib /usr/local/lib64 $LD_LIBRARY_PATH
set -x BROWSER firefox
source ~/.config/fish/keys.fish

# pnpm
set -gx PNPM_HOME "/home/mike/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
