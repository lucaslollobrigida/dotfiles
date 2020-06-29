{config, pkgs, lib, ...}:

with lib;

{
  options = {
    settings = {
      name = mkOption {
        default = "Annon";
      };
      username = mkOption {
        default = "root";
      };
      email = mkOption {
        default = "root@domain.com";
      };
      gpgkey = mkOption {
        default = "";
      };
      github.username = mkOption {
        default = "";
      };
      vm = mkOption {
        default = false;
        type = types.bool;
      };
      terminal = mkOption {
        default = "xterm";
      };
      shell = mkOption {
        default = pkgs.bash;
        # type = types.
      };
      fontName = mkOption {
        default = "Inconsolata";
      };
      fontSize = mkOption {
        default = 12;
        type = types.int;
      };
      profile = mkOption {
        default = "root";
        description = ''
          Profiles are a higher-level grouping than hosts. They are
          useful to combine multiple related things (e.g. ssh keys)
          that should be available on multiple hosts.
        '';
      };
      xkbFile = mkOption {
        default = "none";
        type = with types; uniq string;
        description = ''
          Filename of the xkb file to load (or "none" if no keyboard
          layout is desired). File is specified without extension and
          must be present in the xkb directory.
        '';
      };
    };
  };
}
