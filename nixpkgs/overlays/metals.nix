self: super: {
  metals = super.metals.overrideAttrs (
    old: rec {
      version = "0.10.5";
      deps = self.stdenv.mkDerivation {
        name = "${old.pname}-deps-${version}";
        buildCommand = ''
          export COURSIER_CACHE=$(pwd)
          ${self.coursier}/bin/coursier fetch org.scalameta:metals_2.12:${version} \
            -r bintray:scalacenter/releases \
            -r sonatype:snapshots > deps
          mkdir -p $out/share/java
          cp -n $(< deps) $out/share/java/
        '';
        outputHashMode = "recursive";
        outputHashAlgo = "sha256";
        outputHash = "0n0y522izqlyls3sn2x6mdjy0pmhrl1kr7z5fqac6wrpgcsczf01";
      };
      buildInputs = [ self.jdk deps ];
    }
  );
}
