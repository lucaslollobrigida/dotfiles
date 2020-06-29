{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = config.settings.username;
    userEmail = config.settings.email;
    aliases = {
      s = "status -s";
      c = "clone --recursive";
      last = "log -1 HEAD";
      utg = "reset HEAD --";
      aliases = "config --get-regexp alias";
      glog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
    };
    signing = {
      key = config.settings.gpgkey;
      signByDefault = true;
    };
    ignores = [
      "log/"
      "*.log"
      "*.db"
      "*.sqlite"
      ".DS_Store"
      ".*.swp"
      "*.errors"
      "*.hi"
      "*.so"
      "*.o"
      "*.pyo"
      "*.pyc"
      "*-x86_64-linux"
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"
      "*~"
      "*#"
      ".idea/"
      ".lsp/"
    ];
    extraConfig = {
      color.ui = true;
      "color \"status\"".added = "green";
      "color \"status\"".changed = "blue";
      "color \"status\"".untracked = "red";

      "color \"branch\"".current = "green";
      "color \"branch\"".local = "blue";
      "color \"branch\"".remote = "yellow";

      core.filemode = false;
      core.pager = "less -r";
      core.excludesfile = "~/.config/git/ignore";

      diff.renames = "copies";
      diff.algorithm = "patience";

      format.pretty = "format:\"%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]\"";

      github.user = config.settings.github.username;

      log.abbrevcommit = true;
      log.date = "short";

      merge.tool = "vimdiff";
      mergetool.keepBackup = false;

      push.default = "matching";

      pull.rebase = "yes";
      pull.octopus = "octopus";
    };
  };
}
