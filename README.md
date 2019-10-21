# dotfiles

My configuraration files for:

+ Bash
+ Vim(neovim)
+ Tmux
+ Fonts
+ Git
+ Ctags
+ GNU GPG

## Dependencies

[GNU Stow](https://www.gnu.org/software/stow/)

## Usage

```sh
git clone gitthub.com:lucaslollobrigida/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --recursive --remote

# Backup your files, if needed

stow
```

## Updating

```sh
cd ~/.dotfiles
git pull --recurse-submodules
stow -R
```
