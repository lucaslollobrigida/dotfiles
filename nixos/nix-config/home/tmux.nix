{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    terminal = "tmux-256color";
    clock24 = true;
    historyLimit = 100000;
    extraConfig = ''
    set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'

    bind r source-file ~/.tmux.conf \; display '~/.tmux.conf sourced'

    set-window-option -g automatic-rename on # automatically set window title
    set -g renumber-windows on    # renumber windows when a window is closed
    set-option -g set-titles on
    set -g monitor-activity on

    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip"
    bind-key -T copy-mode-vi Escape send-keys -X cancel

    set -g status-right "#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)"

    bind-key v split-window -h
    bind-key s split-window -v

    bind -r Up resize-pane -U
    bind -r Down resize-pane -D
    bind -r Left resize-pane -L
    bind -r Right resize-pane -R

    bind -r k select-pane -U
    bind -r j select-pane -D
    bind -r h select-pane -L
    bind -r l select-pane -R

    bind -r C-p previous-window
    bind -r C-n next-window

    set -sg escape-time 0

    unbind C-Up
    unbind C-Down
    unbind C-Left
    unbind C-Right

    set -g status-style bg=black,fg=white
    set -g window-status-current-style bg=white,bold,fg=black,bold
    set -g status-interval 60
    set -g status-left-length 30
    set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'

    set -g pane-border-style fg=black
    set -g pane-active-border-style fg=brightred

    set -g status-justify left
    set -g status-bg default
    set -g status-fg colour12
    set -g status-interval 2

    set -g message-style fg=black,bg=yellow
    set -g message-command-style fg=blue,bg=black

    setw -g mode-style bg=colour6,fg=colour0

    setw -g window-status-format " #F#I:#W#F "
    setw -g window-status-current-format " #F#I:#W#F "
    setw -g window-status-format "#[fg=magenta]#[bg=black] #I #[bg=cyan]#[fg=colour8] #W "
    setw -g window-status-current-format "#[bg=brightmagenta]#[fg=colour8] #I #[fg=colour8]#[bg=colour14] #W "
    setw -g window-status-current-style bg=colour0,dim,fg=colour11,dim
    setw -g window-status-style bg=green,reverse,fg=black,reverse

    set -g status-left ""

    set-option -g visual-activity off
    set-option -g visual-bell off
    set-option -g visual-silence off
    set-window-option -g monitor-activity off
    set-option -g bell-action none

    setw -g clock-mode-colour colour135
    setw -g mode-style fg=colour196,bold,bg=colour238,bold

    set -g pane-border-style bg=colour235,fg=colour238
    set -g pane-active-border-style bg=colour236,fg=colour51

    set -g status-position bottom
    set -g status-style bg=colour234,dim,fg=colour137,dim
    set -g status-left ""
    set -g status-right "#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S "
    set -g status-right-length 50
    set -g status-left-length 20

    setw -g window-status-current-style fg=colour81,bold,bg=colour238,bold
    setw -g window-status-current-format " #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F "

    setw -g window-status-style fg=colour138,none,bg=colour235,none
    setw -g window-status-format " #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F "

    setw -g window-status-bell-style fg=colour255,bold,bg=colour1

    set -g message-style fg=colour232,bold,bg=colour166,bold
    '';
  };
}
