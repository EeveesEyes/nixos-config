{ pkgs, config, ... }: {
  imports = [
    ../modules/docker.nix
    ../modules/fonts.nix
    ../modules/gc.nix
    ../modules/nixld.nix
    ../modules/opengl.nix
    ../modules/sound.nix
    ../modules/ssh.nix
    ../modules/udisks2.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Locale
  i18n.defaultLocale = "en_DK.UTF-8";

  nixpkgs.config.allowUnfreePredicate = _: true;
  nixpkgs.config.allowUnfree = true;

  # GTK settings stuff for e.g. themes
  programs.dconf.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [ vim wget curl git ];

  environment.variables = {
    EDITOR = "nvim";
    PATH = "$PATH:/home/hagoromo/bin";
    XDG_SCREENSHOTS_DIR = "/home/hagoromo/screenshots/";
    NIXOS_CONFIG_PATH = "/home/hagoromo/.config/nixos-config";
  };

  environment.interactiveShellInit = ''
    alias get-config-kaguya="scp hagoromo@192.168.178.190:/etc/nixos/hardware-configuration.nix /home/hagoromo/.config/nixos-config/machines/kaguya/hardware-configuration.nix"
    alias deploy-kaguya="nixos-rebuild --target-host hagoromo@192.168.178.190 --use-remote-sudo switch -I nixos-config=$NIXOS_CONFIG_PATH/machines/kaguya/configuration.nix"
  '';

  # weekly trim
  services.fstrim.enable = true;

  nix.settings.trusted-users = [ "root" "@wheel" ];

  # Enable proprietary firmware
  hardware.enableAllFirmware = true;

  # TMP
  networking.firewall = {
    #   allowedTCPPorts = [ 3000 ];
  };

  networking.extraHosts = ''
  '';
}
