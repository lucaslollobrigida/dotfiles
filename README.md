# dotfiles

My configuraration files for:

+ dev
+ git
+ emacs
+ fzf
+ neovim
+ nixos
+ st
+ tmux
+ X
+ xmonad
+ zsh

## Dependencies

[GNU Stow](https://www.gnu.org/software/stow/)

## Usage

```sh
git clone gitthub.com:lucaslollobrigida/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Backup your files, if needed

# packages: dev|git|emacs|fzf|vim|nixos|st|tmux|X|xmonad|zsh
stow <package_name>
```
