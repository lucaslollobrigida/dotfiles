{ config, lib, pkgs, ... }:

let
  inherit (config.user) github gpgkey email name;
in
{
  home.packages = with pkgs; [ github-cli ];

  programs.git = {
    enable = true;

    signing = {
      key = "A9D1FF3A"; #gpgkey;
      signByDefault = true;
    };

    userName = "Lucas Lollobrigida"; # name;
    userEmail = "lucas.lollobrigida@nubank.com.br"; # email;
    package = pkgs.gitFull;

    delta = {
      enable = true;
      # whitespace-error-style = "22 reverse";
      options = {
        features = "side-by-side line-numbers decorations";
        plus-style = ''syntax "#003800"'';
        minus-style = ''syntax "#3f0001"'';
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-style = "bold yellow ul";
          file-decoration-style = "none";
        };
        delta = {
          navigate = true;
        };
      };
    };

    aliases = {
      aliases = "config --get-regexp alias";
      branch-cleanup = ''!git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d #'';
      c = "clone --recursive";
      glog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
      last = "log -1 HEAD";
      logs = "log --show-signature";
      s = "status -s";
      utg = "reset HEAD --";
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

    includes = [ { path = "~/.config/git/local"; } ];

    extraConfig = {
      color.ui = true;
      "color \"status\"".added = "green";
      "color \"status\"".changed = "blue";
      "color \"status\"".untracked = "red";

      "color \"branch\"".current = "green";
      "color \"branch\"".local = "blue";
      "color \"branch\"".remote = "yellow";

      core.filemode = false;

      diff.renames = "copies";
      diff.algorithm = "patience";

      format.pretty = "format:\"%C(yellow)%h%Creset %ad | %Cgreen%s%Creset %Cred%d%Creset %Cblue[%an]\"";

      github.user = "lucaslollobrigida"; # github.username;

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
