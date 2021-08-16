{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    historyLimit = 10000;
    keyMode = "vi";
    newSession = true;
    sensibleOnTop = true;
    shortcut = "a";
    terminal = "screen-256color";
    secureSocket = false;
    extraConfig = ''
      set -as terminal-overrides ',*256col*:Tc:sitm=\E[3m'
      set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'

      set -as terminal-overrides ',*256col*:RGB'

      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

      setw -g automatic-rename on
      set -g set-titles on
      set -g renumber-windows on

      # hostname, window number, program name
      set -g set-titles-string '#H: #S.#I.#P #W'

      # enable mouse pointer actions
      set -g mouse on

      # monitor activity between windows
      setw -g monitor-activity on
      set -g visual-activity on

      # No delay for escape key press
      set -sg escape-time 0

      # split rebinds
      bind-key v split-window -h
      bind-key s split-window -v

      # reload config file (change file location to your the tmux.conf you want to use)
      bind r source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'

      # loud or quiet?
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-window-option -g monitor-activity off
      set-option -g bell-action none
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-show-network true
          set -g @dracula-show-weather false
          set -g @dracula-show-fahrenheit false
          set -g @dracula-cpu-usage true
          set -g @dracula-ram-usage false
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
        '';
      }
      {
        plugin = tmuxPlugins.prefix-highlight;
        extraConfig = ''
          set -g @prefix_highlight_prefix_prompt 'Prefix'
          set -g @prefix_highlight_show_copy_mode 'on'
          set -g @prefix_highlight_copy_prompt 'Copy'
          set -g @prefix_highlight_empty_has_affixes 'on'
          set -g @prefix_highlight_empty_prompt 'Tmux'
        '';
      }
      tmuxPlugins.copycat
      tmuxPlugins.pain-control
      tmuxPlugins.yank
      tmuxPlugins.sensible
    ];
  };
}
