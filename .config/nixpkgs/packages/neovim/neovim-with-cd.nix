{ config }:

# A wrapper around nvim that automatically sets the working directory
# when passing a dir path as argument to the nvim command.
let
  vim = "${config.programs.neovim.finalPackage}/bin/nvim";
  inherit (import ../../pkgs.nix) pkgs;
in
pkgs.writeShellScriptBin "nvimWithCd" ''
  #!/bin/bash

  if [ "$#" -eq 1 ];then # is there a path argument?
    if test -d $1;then # open directory in vim
      ${vim} $1 --cmd ":execute 'cd' argv(0)"
    else # open file in vim
      ${vim} $1 --cmd ":execute 'cd' '$(dirname $1)'"
    fi
  else # no path argument, just open vim
    ${vim} 
  fi
''
