let
  inherit (import <nixpkgs> { }) stdenv;
  inherit (import ../../pkgs.nix) pkgs;
  dataDir = "~/.cronicle";
  storageDir = "${dataDir}/storage";
  logDir = "${dataDir}/logs";
  queueDir = "${dataDir}/queue";
  pidFile = "${dataDir}/pid";
  logArchiveDir = "${dataDir}/log-archives";
  program = stdenv.mkDerivation
    rec {
      version = "0.8.56";
      pname = "cronicle-daemon";
      src =
        (pkgs.fetchFromGitHub {
          owner = "jhuckaby";
          repo = "Cronicle";
          rev = "v${version}";
          sha256 = "1pv190pm346iwbahcn787afavsrl3ddc0wh5xc3ym62gjl8c2al1";
        });
      buildPhase = ''
        PATH="$PATH:${pkgs.nodejs}/bin"
        mkdir ./npm-cache
        ${pkgs.nodejs}/bin/npm install --cache ./npm-cache
        ${pkgs.nodejs}/bin/node bin/build.js dist
        rm -rf ./npm-cache
      '';
      installPhase = ''
        mkdir -p $out
        ${pkgs.nodejs}/bin/node ./bin/storage-cli setup
        cp -r * $out
        rm $out/bin/control.sh
        cp ${./control.sh} $out/bin/control.sh
        chmod +x $out/bin/control.sh
      '';
    };
  env = "
    export CRONICLE_Location=${program};
    export CRONICLE_Storage__Filesystem__base_dir=${storageDir};
    export CRONICLE_log_dir=${logDir};
    export CRONICLE_pid_file=${pidFile};
    export CRONICLE_queue_dir=${queueDir};
    export CRONICLE_log_archive_path=${logArchiveDir};
  ";
  cli = pkgs.writeShellScriptBin "cronicle" ''
    ${env}
    ${program}/bin/control.sh "$@"
  '';
in
cli
