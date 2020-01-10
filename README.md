# dotfiles

My configuraration files for:

+ Zsh
+ Vim(neovim)
+ Tmux
+ Fonts
+ Git
+ Ctags
+ GNU GPG
+ Bash

## Dependencies

[GNU Stow](https://www.gnu.org/software/stow/)

## Usage

```sh
git clone gitthub.com:lucaslollobrigida/dotfiles.git --recursive ~/.dotfiles
cd ~/.dotfiles

# Backup your files, if needed

# packages: vim|bash|git|tmux|ctags|fonts|gpg|zsh
stow <package_name>
```

## Updating

```sh
~/.dotfiles/update.sh
```
