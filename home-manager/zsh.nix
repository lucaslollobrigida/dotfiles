{ pkgs, inputs, ... }:

{
  # TODO: add plugins
  programs.zsh = {
    enable = true;
    autocd = true;
    defaultKeymap = "viins";
    enableCompletion = true;
    enableAutosuggestions = true;

    history = {
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    sessionVariables = {
      # Reduce time to wait for multi-key sequences
      KEYTIMEOUT = 1;
      # Set right prompt to show time
      RPROMPT = "%F{8}%*";
      # zsh-users config
      ZSH_AUTOSUGGEST_USE_ASYNC = 1;
      ZSH_HIGHLIGHT_HIGHLIGHTERS = [ "main" "brackets" "cursor" ];

      HISTSIZE = 999999999;
      SAVEHIST = 999999999;

      LEIN_USE_BOOTCLASSPATH = "no";
    };

    shellAliases = {
      ls = "exa --color=always --group-directories-first";
      ll = "exa -l --color=always --group-directories-first";
      la = "exa -al --color=always --group-directories-first";
      lt = "exa -aT --color=always --group-directories-first";
    };

    initExtra = ''
      setopt correct
      setopt noflowcontrol
      setopt hist_ignore_all_dups
      setopt hist_ignore_space

      # Edit in vim
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey -M vicmd v edit-command-line

      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$HOME/go/bin:$PATH"

      [ -f ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme ] && source ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
      [ -f ~/.p10k.zsh ] && source ~/.p10k.zsh
      [ -f ~/.nurc ] && source ~/.nurc
    '';

    plugins = [
      {
        name = "powerlevel10k";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "v1.15.0";
          sha256 = "1b3j2riainx3zz4irww72z0pb8l8ymnh1903zpsy5wmjgb0wkcwq";
        };
      }
    ];
  };

  programs.autojump.enable = true;
  programs.dircolors.enable = true;

  programs.fzf = {
    enable = true;
    fileWidgetOptions = [ "--preview 'head {}'" ];
    historyWidgetOptions = [ "--sort" ];
  };
}
