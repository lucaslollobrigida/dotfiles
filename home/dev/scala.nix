{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [
    ammonite
    bloop
    coursier
    dotty
    metals
    sbt
    scalafix
    scalafmt
  ];
}
