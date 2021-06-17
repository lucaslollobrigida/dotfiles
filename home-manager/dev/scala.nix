{ pkgs, ... }:

{
  home.packages = with pkgs; [
    coursier
    dotty
    metals
    sbt
    scalafix
    scalafmt
  ];
}
