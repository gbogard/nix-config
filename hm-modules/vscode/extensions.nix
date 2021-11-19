let
  pkgs = (import ../../nixpkgs);
  nixpkgsExts = with pkgs.vscode-extensions;
    [
      dbaeumer.vscode-eslint
      haskell.haskell
      vscodevim.vim
      pkief.material-icon-theme
      ms-vscode-remote.remote-ssh
      matklad.rust-analyzer
      jnoortheen.nix-ide
      esbenp.prettier-vscode
      serayuzgur.crates
      tamasfe.even-better-toml
    ];
  marketplaceExts = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "scala";
      publisher = "scala-lang";
      version = "0.5.4";
      sha256 = "1a27yq29g9md98cm1gsb0sjw9hy1jsnqzxd91r7vq7infvcc1i26";
    }
    {
      name = "metals";
      publisher = "scalameta";
      version = "1.10.11";
      sha256 = "10zh04ib6prjc2mlyihp8a6j4j428j7xp64kak1y356shvmccqzs";
    }
    {
      name = "gruvbox-material";
      publisher = "sainnhe";
      version = "6.4.6";
      sha256 = "17xddfkxfgj9qls1364c8iqk359rk0k6fc6xpl93zzqr43hx4vxf";
    }
  ];
in
nixpkgsExts ++ marketplaceExts
