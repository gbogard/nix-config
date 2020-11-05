{ config, pkgs, ... }:

let
  java = pkgs.jdk11;
  javaOpts = { jre = java; };
  sbt = pkgs.sbt.override javaOpts;
  scala = pkgs.sbt.override javaOpts;
  coursier = pkgs.coursier.override javaOpts;
  metals = pkgs.metals.override javaOpts;
  scalafmt = pkgs.scalafmt.override javaOpts;
in
{
  home.packages = [
    java
    sbt
    scala
    coursier
    scalafmt
  ];
  home.sessionVariables.JAVA_HOME = java.home;
}
