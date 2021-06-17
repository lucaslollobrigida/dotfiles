{ lib, pkgs, ... }:
{
  home.packages = with pkgs.nubank; [
    dart
    flutter
    pkgs.google-chrome
  ] ++ desktop-tools;

  # This is a hack to override priorities for those packages in PATH
  home.sessionVariables.PATH = with pkgs.nubank;
    "${lib.makeBinPath ([ dart flutter hover ] ++ all-tools)}:$PATH";

}
