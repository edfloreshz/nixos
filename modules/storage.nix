{ ... }:
{
  fileSystems."/mnt/delta" = {
    device = "/dev/disk/by-uuid/f907b68d-ef8c-419c-8bc6-d658fa75b7bc";
    fsType = "ext4";
  };

  fileSystems."/mnt/omega" = {
    device = "/dev/disk/by-uuid/1d79d43c-3c73-422c-ade9-3ce7392c442e";
    fsType = "ext4";
  };
}
