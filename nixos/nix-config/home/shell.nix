{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    dotDir = ".config/shell";
    localVariables = {
      CASE_SENSITIVE = "true";
      DISABLE_AUTO_TITLE = "true";
      DISABLE_UNTRACKED_FILES_DIRTY = "true";
      ZSH_AUTOSUGGEST_STRATEGY="(history completion)";
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
    history.path = "/${config.xdg.dataHome}/zsh/zsh_history";
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      theme = "lambda";
      plugins = [
        "git"
        "fzf"
        "tmux"
        "vi-mode"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        ];
    };
  };
}
