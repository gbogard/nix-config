let
  inherit (import ../../pkgs.nix) unstable pkgs;
  java = unstable.graalvm11-ce;
  intellij = unstable.jetbrains.idea-community.override { jdk = java; };
  intellijWithApp = pkgs.stdenv.mkDerivation rec {
    pname = "idea-community-app";
    version = "0.0.0";
    src = [];
    phases = [ "unpackPhase" ];
    buildInputs = [
      intellij
    ];
    unpackPhase = ''
    app=$out/Applications/IntellijIDEA.app;
    script="$app/Contents/MacOS/IntellijIDEA";
    mkdir -p $app/Contents/MacOS;
    touch $script;
    chmod +x $script;
    echo "#!/usr/bin/env bash" >> $script;
    echo "${intellij}/bin/idea-community" >> $script;
    '';
  };
in
{
  home.packages = [ intellij intellijWithApp ];
}
