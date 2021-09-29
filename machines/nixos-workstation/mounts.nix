{ ... }:
let
  # this line prevents hanging on network split
  automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  smbShare = path: {
    device = "//192.168.1.83/${path}";
    fsType = "cifs";
    options = [ "${automount_opts},credentials=/etc/nixos/smb-secrets" ];
  };
in
{
  fileSystems."/mnt/shares/guillaume" = smbShare "guillaume";
  fileSystems."/mnt/shares/isos" = smbShare "isos";
}
