#! /usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

mkdir -p $HOME/.config/tmux
rm -rf $HOME/.config/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/tmux/tmux.conf $HOME/.config/tmux/tmux.conf
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

rm -rf $HOME/.config/nvim
ln -s $DOTFILES/nvim $HOME/.config/nvim
