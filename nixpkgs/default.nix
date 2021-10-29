import
  (builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/e03daba08cead5b6597dbca9fcf33a6a7e0cd0b8.tar.gz"; })
  { overlays = (import ./overlays); }
