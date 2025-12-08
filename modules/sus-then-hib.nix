{ config, pkgs, ... }:
{
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleSuspendKey = "suspend-then-hibernate";
    HandlePowerKey = "suspend-then-hibernate";
  };
}

