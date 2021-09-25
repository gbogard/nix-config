self: super: {
  jetbrains = super.jetbrains // rec {
    idea-community = super.jetbrains.idea-community.override { jdk = super.graalvm11-ce; };
    idea-community-darwin = self.stdenv.mkDerivation rec {
      pname = "idea-community-app";
      version = "0.0.0";
      src = [];
      phases = [ "unpackPhase" ];
      buildInputs = [
        idea-community
      ];
      unpackPhase = ''
        app=$out/Applications/IntellijIDEA.app;
        script="$app/Contents/MacOS/IntellijIDEA";
        mkdir -p $app/Contents/MacOS;
        touch $script;
        chmod +x $script;
        echo "#!/usr/bin/env bash" >> $script;
        echo "${idea-community}/bin/idea-community" >> $script;
      '';
    };
  };
}
