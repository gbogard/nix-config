let
  inherit (import ../../pkgs.nix) pkgs;
  doom-emacs = pkgs.callPackage
    (pkgs.fetchFromGitHub {
      owner = "vlaci";
      repo = "nix-doom-emacs";
      rev = "51645030623075a50f0f2fb8e95d113336fa109f";
      sha256 = "1f8lwcp99rga8ckyiad56dzyli0rd8mi48nw638gw069q6mfx3h3";
    })
    {
      doomPrivateDir = ./doom.d; # Directory containing your config.el init.el
      # and packages.el files
    };
in
{
  home.packages = [
    doom-emacs
    pkgs.emacs-all-the-icons-fonts
    pkgs.fira-code-symbols
  ];
  home.file.".emacs.d/init.el".text = ''
    (load "default.el")
  '';
}
