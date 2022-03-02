#!/bin/bash
set -e

# Part 0: Back up oh my zsh stuff so it doesn't complain
mkdir -p "$HOME/.dotfiles-backup"
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Backing up existing oh my zsh folder."
    mv --backup=numbered "$HOME/.oh-my-zsh"/ "$HOME/.dotfiles-backup/"
fi

# Part 1: Get the oh my zsh things working
echo "Installing oh my zsh and plugins!"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null
echo "    powerlevel10k..."
git clone -qq --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
echo "    auto suggestions..."
git clone -qq https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
echo "    completions..."
git clone -qq https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions"
echo "    syntax highlighting..."
git clone -qq https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
echo "    history substring search..."
git clone -qq https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"

# Part 2: Get the .dotfiles bare repo in place
if [ -d "$HOME/.dotfiles" ]; then
    echo "Backing up .dotfiles folder."
    mv --backup=numbered "$HOME/.dotfiles" "$HOME/.dotfiles-backup"
fi
git clone -qq --bare https://github.com/Syzygianinfern0/dotfiles.git "$HOME/.dotfiles"
function config {
    /usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

# Part 3: Getting the actual dot files in place and backing-up already existing files
if config checkout &> /dev/null ; then
    echo "Checked out config."
else
    echo "Backing up pre-existing dot files (caution - this maybe messy but works)."
    config checkout 2>&1 | grep -E "^\s+" | xargs -I "{}" mv --backup=numbered "$HOME/{}" "$HOME/.dotfiles-backup/"
fi
config checkout
config config status.showUntrackedFiles no
echo "Complete!"
