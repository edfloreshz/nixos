{ ... }:
{
  # Keep this laptop awake as a headless server: ignore lid close,
  # disable sleep/suspend/hibernate targets entirely.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hibernate-suspend.enable = false;
}
