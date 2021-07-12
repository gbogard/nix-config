rec {
  metals_overlay = self: super: {
    metals = super.metals.overrideAttrs (old: rec {
      version = "0.10.3";
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
        outputHash = "1psmsiwd3xlbrvkdvr2zgs2b66kw8w2jvvqa399g7jhixh2fpbx4";
      };
      buildInputs = [ self.jdk deps ];
    });
  };
  moz_overlay = import (builtins.fetchTarball {
    url = "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";
    sha256 = "1zybp62zz0h077zm2zmqs2wcg3whg6jqaah9hcl1gv4x8af4zhs6";
  });
  neovim_overlay = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/c2a8577b755101ba3cd5d8b20a1a46f231b76a11.tar.gz";
    sha256 = "0bjsrjic21pi93yiv3kiabhs43hf4c2vv5ypqp4nvc602wgxrqa7";
  });
  pkgs =
    (import
      (builtins.fetchTarball {
        name = "nixos-20.09";
        url = "https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz";
        sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
      })
      { overlays = [ moz_overlay neovim_overlay ]; });
  unstable =
    import
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/5658fadedb748cb0bdbcb569a53bd6065a5704a9.tar.gz";
        sha256 = "1kpmhd9v5a3fbwq86spd1p5s4npfd1jrjl14kl6h1n1l1qd6cbp6";
      })
      { overlays = [ neovim_overlay metals_overlay ]; };
}
