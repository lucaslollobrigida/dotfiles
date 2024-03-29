# dotfiles

Common configuration across unix environments:
+ Nix(OS) as a distro and package management tool (powered by flake)
+ AwesomeWM as window manager

## Topology

```sh
.
├── cachix
├── conf
├── home
├── hosts
│  └── some-host
│  └── another-host
├── modules
├── nixos
└── overlays

```

1. **Cachix**: Cachix binary cache definitions.
2. **Conf**: Non nix configuration (yet), eg. vim scripts, awesome configuration, etc ... At some point they will converge to nix.
3. **Home**: Per user config.
4. **Hosts**: Per host configuration, compose all global configuration used by a machine.
5. **Modules**: Used as "abstract type definitions", like `user` or other abstractions.
6. **Nixos**: Global (across users) related settings, like perifericals, internet, bluetooth, and so on.
6. **Overlays**: Custom extensions or overrides of definided packages or other overlays.

## Usage

On a working nixos and flakes setup:

```sh
git clone https://github.com/lucaslollobrigida/dotfiles.git /etc/nixos

sudo nixos-rebuild switch --flake "/etc/nixos#<some-host>"

# to update flake lock
sudo nixos-rebuild switch --flake "/etc/nixos#<some-host>" --recreate-lock-file
```

# Todo

+ [ ] Update tmux theme (maybe [this?](https://github.com/wfxr/tmux-power)).
+ [ ] Fix user modules not acessible on home config.
+ [ ] Fix alternate files in Scala. Source -> test is working, but not the other way around
