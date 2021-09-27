env:
let
  pkgs = (import ../../nixpkgs);
in
{

  home.packages = with pkgs; [
    graalvm11-ce
    sbt
    pkgs.scala
    coursier
    bloop
    scalafmt
    metals
    maven
  ];
  home.sessionVariables.JAVA_HOME = pkgs.graalvm11-ce.home;
}
