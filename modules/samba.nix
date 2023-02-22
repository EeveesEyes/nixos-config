{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [ lxqt.lxqt-policykit ]; # provides a default authentification client for policykit

  services.gvfs.enable = true;
}
