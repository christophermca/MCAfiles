#!/bin/bash
# symlink dotfiles

if [ ! -L "$HOME/.vim" ]; then
  ln -s ~/Repos/dotfiles/.vim/ ~/.vim
fi

if [ ! -L "$HOME/.vimrc" ]; then
  ln -s ~/Repos/dotfiles/.vim/.vimrc ~/.vimrc
fi

if [ ! -L "$HOME/.profile" ]; then
  ln -s ~/Repos/dotfiles/.profile ~/.profile
fi

if [ ! -L "$HOME/.bashrc" ]; then
  ln -s ~/Repos/dotfiles/.bashrc ~/.bashrc
fi

if [ ! -L "$HOME/.workrc" ]; then
  ln -s ~/Repos/dotfiles/.workrc ~/.workrc
fi

if [ ! -L "$HOME/.inputrc" ]; then
  ln -s ~/Repos/dotfiles/.inputrc ~/.inputrc
fi

if [ ! -L "$HOME/.gitconfig" ]; then
  ln -s ~/Repos/dotfiles/.gitconfig ~/.gitconfig
fi

if [ ! -L "$HOME/.tmux.conf" ]; then
  ln -s ~/Repos/dotfiles/.tmux.conf ~/.tmux.conf
fi

if [ ! -L "$HOME/.tmuxinator" ]; then
  ln -s ~/Repos/dotfiles/.tmuxinator ~/.tmuxinator
fi

if [ ! -L "$HOME/.vundle" ]; then
  ln -s ~/Repos/dotfiles/.vundle ~/.vundle
fi

# Load .profile, containing login, non-bash related initializations.
source ~/.profile

# Load .workrc, containing only work related bash config and initializations.
if [ -f "$HOME/.workrc" ]; then
   source ~/.workrc
fi

# Load .bashrc, containing non-login related bash initializations.
source ~/.bashrc

# Load .tmuxinator, containing tmuxinator logic
source ~/bin/tmuxinator.bash
export PATH="$PYENV_ROOT/bin:$PATH"
