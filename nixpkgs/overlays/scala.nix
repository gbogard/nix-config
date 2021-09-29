self: super: let
  javaOpts = { jre = super.graalvm11-ce; };
in
{
  sbt = (super.sbt.overrideAttrs (old: { installCheckPhase = ""; })).override javaOpts;
  scala = (super.scala.overrideAttrs (old: { postInstall = "rm -f $out/LICENSE"; })).override javaOpts;
  coursier = super.coursier.override javaOpts;
  bloop = super.bloop.override javaOpts;
  metals = super.metals.override javaOpts;
  scalafmt = super.scalafmt.override javaOpts;
  maven = super.maven.override { jdk = super.graalvm11-ce; };
}
