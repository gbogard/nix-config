rec {
  pkgs = 
    import (builtins.fetchTarball {
      name = "nixos-20.09";
      url = "https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz";
      sha256 = "1wg61h4gndm3vcprdcg7rc4s1v3jkm5xd7lw8r2f67w502y94gcy";
    }) {};
  unstable =
    import (pkgs.fetchFromGitHub {
      owner  = "NixOS";
      repo   = "nixpkgs";
      rev    = "7741f925f16e26ab9c601291337e3efb46d00dec";
      sha256 = "1cbi5kiaxd70rv2mvr68qmyw3f0v0hv14i85bl2bzvgxm49rar2l";
    }) {};
}
