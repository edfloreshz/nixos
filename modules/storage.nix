{ ... }:
{
  fileSystems."/mnt/delta" = {
    device = "/dev/disk/by-uuid/f907b68d-ef8c-419c-8bc6-d658fa75b7bc";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" "x-systemd.device-timeout=10" ];
  };

  fileSystems."/mnt/omega" = {
    device = "/dev/disk/by-uuid/1d79d43c-3c73-422c-ade9-3ce7392c442e";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.automount" "x-systemd.device-timeout=10" ];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="block", ENV{ID_FS_UUID}=="f907b68d-ef8c-419c-8bc6-d658fa75b7bc", TAG+="systemd", ENV{SYSTEMD_WANTS}+="mnt-delta.mount"
    SUBSYSTEM=="block", ENV{ID_FS_UUID}=="1d79d43c-3c73-422c-ade9-3ce7392c442e", TAG+="systemd", ENV{SYSTEMD_WANTS}+="mnt-omega.mount"
  '';
}
