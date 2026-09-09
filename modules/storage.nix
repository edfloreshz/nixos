{ ... }:
{
  fileSystems."/media/Delta" = {
    device = "/dev/disk/by-uuid/6A9D-9852";
    fsType = "exfat";
    options = [ "nofail" "x-systemd.automount" "x-systemd.device-timeout=10" "gid=986" "dmask=0002" "fmask=0113" ];
  };

  fileSystems."/media/Omega" = {
    device = "/dev/disk/by-uuid/1d79d43c-3c73-422c-ade9-3ce7392c442e";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" "x-systemd.device-timeout=10" ];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="block", ENV{ID_FS_UUID}=="6A9D-9852", TAG+="systemd", ENV{SYSTEMD_WANTS}+="media-Delta.mount"
    SUBSYSTEM=="block", ENV{ID_FS_UUID}=="1d79d43c-3c73-422c-ade9-3ce7392c442e", TAG+="systemd", ENV{SYSTEMD_WANTS}+="media-Omega.mount"
  '';
}
