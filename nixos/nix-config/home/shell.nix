{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    # dotDir = ".config/shell";
    localVariables = {
      CASE_SENSITIVE = "true";
      DISABLE_AUTO_TITLE = "true";
      DISABLE_UNTRACKED_FILES_DIRTY = "true";
      ZSH_AUTOSUGGEST_STRATEGY = "(history completion)";
    };
    initExtra = ''
      [ -f ~/.nurc ] && source ~/.nurc
      [ -f ~/.functions ] && source ~/.functions
        '';
    shellAliases = {
      ls = "exa --color=always --group-directories-first";
      ll = "exa -l --color=always --group-directories-first";
      la = "exa -al --color=always --group-directories-first";
      lt = "exa -aT --color=always --group-directories-first";

      rr = "ranger";
      so = "source $HOME/.zshrc";

      home-switch = "home-manager -f $HOME/nix-config/home/home.nix switch";
      system-switch = "sudo nixos-rebuild switch -I $HOME/nix-config/host/desktop.nix -I $HOME/.nix-channels";
    };
    # history.path = "${config.xdg.dataHome}/zsh";
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "2f3b98ff6f94ed1b205e8c47d4dc54e6097eacf4";
          sha256 = "1lyas0ql3v5yx6lmy8qz13zks6787imdffqnrgrpfx8h69ylkv71";
        };
      }
      {
        name = "spaceship-prompt";
        file = "spaceship.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "denysdovhan";
          repo = "spaceship-prompt";
          rev = "v3.11.2";
          sha256 = "1q7m9mmg82n4fddfz01y95d5n34xnzhrnn1lli0vih39sgmzim9b";
        };
      }
      # {
      #   name = "pure";
      #   file = "pure.zsh";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "sindresorhus";
      #     repo = "pure";
      #     rev = "v1.12.0";
      #     sha256 = "1h04z7rxmca75sxdfjgmiyf1b5z2byfn6k4srls211l0wnva2r5y";
      #   };
      # }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "fzf"
        "tmux"
        "vi-mode"
        ];
    };
  };
}
