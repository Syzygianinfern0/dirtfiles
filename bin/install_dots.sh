#!/bin/bash

# Part 0: Back up oh my zsh stuff so it doesnt complain
mkdir -p $HOME/.dotfiles-backup
if [ -d $HOME/.oh-my-zsh ]; then
  echo "Backing up oh my zsh folder."
  mv $HOME/.oh-my-zsh/ $HOME/.dotfiles-backup/
fi

# Part 1: Get the oh my zsh things working
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone -qq --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone -qq https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone -qq https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone -qq https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone -qq https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Part 2: Get the dotfiles in place
if [ -d $HOME/.dotfiles ]; then
  echo "Backing up .dotfiles folder."
  mv $HOME/.dotfiles $HOME/.dotfiles-backup
fi
git clone -qq --bare https://github.com/Syzygianinfern0/dotfiles.git $HOME/.dotfiles
function config {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "^\s+" | xargs -I '{}' mv {} .dotfiles-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
