# dotfiles

My configuraration files for:

+ dev
+ emacs
+ neovim
+ nixos
+ xmonad

## Dependencies

[GNU Stow](https://www.gnu.org/software/stow/)

## Usage

```sh
git clone gitthub.com:lucaslollobrigida/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Backup your files, if needed

# packages: dev|emacs|vim|nixos|xmonad
stow <package_name>
```
