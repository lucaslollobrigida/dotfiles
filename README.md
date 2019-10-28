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
git clone gitthub.com:lucaslollobrigida/dotfiles.git --recursive ~/.dotfiles
cd ~/.dotfiles

# Backup your files, if needed

# packages: vim|bash|git|tmux|ctags|fonts|gpg
stow package_name
```

## Updating

```sh
cd ~/.dotfiles
git pull --recurse-submodules
git submodule update --init --recursive --remote
```
