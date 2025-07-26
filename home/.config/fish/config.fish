# Move color setting to a separate function that runs only when needed
function set_kitty_colors
    set color_file ~/.cache/ags/user/generated/kitty-colors.conf
    if test -f $color_file
        kitty @ set-colors --all --configured $color_file
    else
        echo "Color scheme file not found: $color_file"
    end
end

if status is-interactive
    set fish_greeting
    
    # Only run starship init if it exists
    type -q starship; and starship init fish | source

    # Only try to read sequences if the file exists
    set -l seq_file ~/.cache/ags/user/generated/terminal/sequences.txt
    if test -f $seq_file
        cat $seq_file
    end
end

# Your aliases here
alias pamcan=pacman
alias cat="mcat"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -Ux EDITOR nvim
set -Ux VISUAL nvim

fish_add_path /home/unity/.spicetify
