{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    bloop
    coursier
    dotty
    metals
    sbt
    scalafix
    scalafmt
  ];
}
