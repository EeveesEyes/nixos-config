# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  home-manager = (import ./nix/sources.nix).home-manager;
  secretsFile = "/root.key";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${home-manager}/nixos"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
    configurationLimit = 5;
  };

  # enable passing of keyfile between grub and initrd
  boot.initrd.luks.devices."cryptroot" = {
    fallbackToPassword = true;
    keyFile = secretsFile;
  };
  # copy the secret into the additional initramfs. `null` means same path
  boot.initrd.secrets."${secretsFile}" = null;


  networking.hostName = "jimbo"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  networking.useDHCP = false;
  networking.networkmanager.enable = true;


  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

    xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fleaz = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
  ];

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  #virtualisation.podman = {
  #enable=true;
  #dockerCompat = true;
  #dockerSocket.enable = true;
  #};

  # i need docker because of the --link flag
  virtualisation.docker.enable = true;

  home-manager.users.fleaz = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      httpie
      _1password-gui

      vscode
      vscode-extensions.vscodevim.vim


      wdisplays
      albert
      firefox
      chromium
      discord
      gnome.gnome-keyring
      via
      docker-compose
      rocketchat-desktop
      hicolor-icon-theme
      gnome3.adwaita-icon-theme
      cinnamon.nemo
      awscli
      element-desktop
      signal-desktop

      dnsutils
      mtr
      tig
      ncdu
      fd
      fzf
      silver-searcher
      thunderbird-wayland
      mosh
      mpv
      poetry
      go
      python3Minimal

      swaylock
      swayidle
      wl-clipboard
      mako
      waybar
      sway-contrib.grimshot
      albert
      foot
      wofi
      fira-code
      prusa-slicer
      htop
    ];


    programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [ vim-airline neoformat vim-monokai ];
      extraConfig = ''
        set mouse=a
      '';
    };

    programs.zsh = {
    	enable = true;
	sessionVariables = {
	  GOPATH = "/home/fleaz/workspace/go";
	};
	oh-my-zsh = {
		enable = true;
		plugins = [ "git" "fzf" ];
		theme = "robbyrussell";
	};
	history.size = 10000;
    };

    programs.git = {
      enable = true;
      userName = "fleaz";
      userEmail = "mail@felixbreidenstein.de";
    };

    programs.waybar = {
      enable = true;
    };

    programs.mako = {
      enable = true;
      groupBy = "app-name";
      defaultTimeout = 5000;
    };

    services.kanshi = {
      enable = true;

    };

    services.redshift = {
      enable = true;
      package = pkgs.gammastep;
      latitude = "49.8";
      longitude = "8.6";
      tray = true;
      settings = {
        brightness = {
          day = "1";
          night = "0.5";
        };
      };
      temperature = {
        night = 3500;
        day = 5500;
      };
    };


    services.blueman-applet.enable = true;

    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "FiraCode:size=14";
        };
        scrollback = {
          lines = 100000;
        };
        colors = {
          alpha = "0.98";
          foreground = "B3B1AD";
          background = "0A0E14";
          regular0 = "01060E";
          regular1 = "EA6C73";
          regular2 = "91B362";
          regular3 = "F9AF4F";
          regular4 = "53BDFA";
          regular5 = "FAE994";
          regular6 = "90E1C6";
          regular7 = "C7C7C7";
          bright0 = "686868";
          bright1 = "F07178";
          bright2 = "C2D94C";
          bright3 = "FFB454";
          bright4 = "59C2FF";
          bright5 = "FFEE99";
          bright6 = "95E6CB";
          bright7 = "FFFFFF";
        };
      };
    };



    wayland.windowManager.sway = {
      enable = true;

      config = {
        modifier = "Mod4";
        focus.followMouse = false;

        input = {
          "17498:8800:KBDFans_DZ60" = {
            xkb_layout = "eu";
          };
          #"1133:49295:Logitech_G403_HERO_Gaming_Mouse" = {
          #  pointer_accel = "1";
          #};
        };
        output = {
          "*".bg = "/home/fleaz/Downloads/spongebob.jpg fill";
          "DVI-D-1" = {
            mode = "1920x1200";
            transform = "270";
            position = "0,0";
          };
          "HDMI-A-1" = {
            mode = "3840x2160";
            scale = "1.2";
            position = "1200,0";
          };
          "DP-1" = {
            mode = "3840x2160";
            scale = "1.2";
            position = "4400,0";
          };

        };
        gaps = {
          inner = 8;
        };
        window.border = 0;
        workspaceAutoBackAndForth = true;
        terminal = "foot";

        bars = [{
          command = "${pkgs.waybar}/bin/waybar";
        }];

        keybindings =
          let
            mod = "Mod4";
          in
          {
            "${mod}+Return" = "exec foot";
            "${mod}+p" = "exec ${pkgs.wofi}/bin/wofi --show drun";

            "${mod}+Shift+c" = "reload";
            "${mod}+Shift+q" = "kill";
            "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
            "${mod}+x" = "move workspace to output right";

            "${mod}+h" = "focus left";
            "${mod}+j" = "focus down";
            "${mod}+k" = "focus up";
            "${mod}+l" = "focus right";

            "${mod}+Shift+h" = "move left";
            "${mod}+Shift+j" = "move down";
            "${mod}+Shift+k" = "move up";
            "${mod}+Shift+l" = "move right";

            "${mod}+s" = "split v";
            "${mod}+w" = "split h";

            "${mod}+t" = "layout tabbed";
            "${mod}+r" = "mode resize";

            "${mod}+f" = "fullscreen toggle";
            "${mod}+Shift+space" = "floating toggle";

            "${mod}+1" = "workspace 1";
            "${mod}+2" = "workspace 2";
            "${mod}+3" = "workspace 3";
            "${mod}+4" = "workspace 4";
            "${mod}+5" = "workspace 5";
            "${mod}+6" = "workspace 6";
            "${mod}+7" = "workspace 7";
            "${mod}+8" = "workspace 8";
            "${mod}+9" = "workspace 9";
            "${mod}+0" = "workspace 10";

            "${mod}+Shift+1" = "move container to workspace 1";
            "${mod}+Shift+2" = "move container to workspace 2";
            "${mod}+Shift+3" = "move container to workspace 3";
            "${mod}+Shift+4" = "move container to workspace 4";
            "${mod}+Shift+5" = "move container to workspace 5";
            "${mod}+Shift+6" = "move container to workspace 6";
            "${mod}+Shift+7" = "move container to workspace 7";
            "${mod}+Shift+8" = "move container to workspace 8";
            "${mod}+Shift+9" = "move container to workspace 9";
            "${mod}+Shift+0" = "move container to workspace 10";


            # Multimedia Keys
            "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
          };

      };
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

