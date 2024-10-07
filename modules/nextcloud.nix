{ config, pkgs, ... }:
{
  # Environment setup for Nextcloud admin and database passwords
  environment.etc."nextcloud-admin-pass".text = "SECURE_PASSWORD_HERE";
  environment.etc."nextcloud-db-pass".text = "SECURE_PASSWORD_HERE";

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "kaguya";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    configureRedis = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
    extraAppsEnable = true;
    maxUploadSize = "10G"; # Adjust for max upload size
  };
}