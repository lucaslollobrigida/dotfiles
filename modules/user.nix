{ pkgs, lib, ... }:

with lib; {
  options.user = {
    name = mkOption {
      type = types.str;
      default = "Annon";
    };
    username = mkOption {
      type = types.str;
      default = "lollo";
    };
    email = mkOption {
      type = types.str;
      default = "root@domain.com";
    };
    github.username = mkOption {
      type = types.str;
      default = "";
    };
    gpgkey = mkOption {
      type = types.str;
      default = "";
    };
    shell = mkOption {
      default = pkgs.zsh;
      type = types.package;
    };
  };
}
