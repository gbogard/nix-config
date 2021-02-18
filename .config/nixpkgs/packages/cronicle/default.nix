let
  inherit (import <nixpkgs> { }) stdenv;
  inherit (import ../../pkgs.nix) pkgs;
  dataDir = "~/.cronicle";
  storageDir = "${dataDir}/storage";
  logDir = "${dataDir}/logs";
  queueDir = "${dataDir}/queue";
  pidFile = "${dataDir}/pid";
  logArchiveDir = "${dataDir}/log-archives";
  version = "0.8.56";
  src =
    (pkgs.fetchFromGitHub {
      owner = "jhuckaby";
      repo = "Cronicle";
      rev = "v${version}";
      sha256 = "1pv190pm346iwbahcn787afavsrl3ddc0wh5xc3ym62gjl8c2al1";
    });
  nodeDependencies = (pkgs.callPackage ./node2nix/default.nix { }).shell.nodeDependencies;
  program = stdenv.mkDerivation
    {
      inherit src version;
      pname = "cronicle-daemon";
      buildPhase = ''
        mkdir -p $out
        cp -r * $out
      '';
      installPhase = ''
        export PATH="${nodeDependencies}/bin:$PATH"
        cd $out
        rm ./bin/control.sh
        cp ${./control.sh} ./bin/control.sh
        chmod +x ./bin/control.sh
        ln -s ${nodeDependencies}/lib/node_modules ./node_modules
        ${pkgs.nodejs}/bin/node ./bin/build dist
      '';
    };
  env = "
    export CRONICLE_Location=${program};
    export CRONICLE_Storage__Filesystem__base_dir=${storageDir};
    export CRONICLE_log_dir=${logDir};
    export CRONICLE_pid_file=${pidFile};
    export CRONICLE_queue_dir=${queueDir};
    export CRONICLE_log_archive_path=${logArchiveDir};
    export CRONICLE_job_memory_max=0;
  ";
in
pkgs.writeShellScriptBin "cronicle" ''
  ${env}
  ${program}/bin/control.sh "$@"
''
