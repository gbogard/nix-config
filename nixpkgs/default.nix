import
  (builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/5cb226a06c49f7a2d02863d0b5786a310599df6b.tar.gz"; })
  { overlays = (import ./overlays); }
