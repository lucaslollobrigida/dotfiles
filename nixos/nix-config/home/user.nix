{ config, pkgs, ... }:

{
  settings = {
    username = "lollo";
    name = "Lucas Lollobrigida";
    email = "lucaslollobrigida@gmail.com";
    github.username = "lucaslollobrigida";
    gpgkey = "4915B7BB723C366C";
    shell = pkgs.zsh;
    fontName = "SauceCodePro Nerd Font";
    fontSize = 16;
  };

}
