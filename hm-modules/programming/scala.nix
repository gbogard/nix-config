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
    scalafmt
    # bloop
    # metals
    maven
    # jetbrains.idea-community
    # jetbrains.idea-community-darwin
  ];
  home.sessionVariables.JAVA_HOME = pkgs.graalvm11-ce.home;
}
