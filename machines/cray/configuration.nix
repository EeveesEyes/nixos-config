# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cray"; # Define your hostname.

  networking.interfaces.eno1.wakeOnLan.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  nix.buildMachines = [{
    hostName = "phoibe.cased.de";
    sshUser = "fleaz";
    sshKey = "/home/fleaz/.ssh/id_phoibe";
    system = "x86_64-linux";
    # if the builder supports building for multiple architectures, 
    # replace the previous line by, e.g.,
    # systems = ["x86_64-linux" "aarch64-linux"];
    maxJobs = 8;
    speedFactor = 2;
    #supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    supportedFeatures = [ ];
    mandatoryFeatures = [ ];
  }];
  nix.distributedBuilds = true;
  # optional, useful when the builder has a faster internet connection than yours
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #  services.xserver.videoDrivers = ["nvidia"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

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
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # allow evil closed-source code
  nixpkgs.config.allowUnfree = true;

    virtualisation.podman = {
	    enable=true;
	    dockerCompat = true;
    };

  home-manager.users.fleaz = { pkgs, ... }: {
    home.packages = with pkgs; [
      httpie
      _1password-gui

      vscode
      vscode-extensions.vscodevim.vim

      wdisplays
      wofi
      firefox
      discord
      gnome.gnome-keyring
      via
      docker-compose


      swaylock
      swayidle
      wl-clipboard
      mako
      waybar
      sway-contrib.grimshot
      foot
      fira-code
      prusa-slicer
      htop
    ];


    programs.vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ vim-airline neoformat vim-monokai ];
      settings = { ignorecase = true; };
      extraConfig = ''
        set mouse=a
      '';
    };

    programs.zsh.enable = true;

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

    services.redshift = {
      enable = true;
      package = pkgs.gammastep;
      latitude = "49.52";
      longitude = "10.17";
      temperature = {
        day = 6500;
        night = 3500;
      };
    };

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
	input = {
		"17498:8800:KBDFans_DZ60" = {
			xkb_layout = "eu";
		};
		#"1133:49295:Logitech_G403_HERO_Gaming_Mouse" = {
		#	pointer_accel = "1";
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
	workspaceAutoBackAndForth =  true;
	terminal = "foot";

	bars = [ {
            command = "${pkgs.waybar}/bin/waybar";
        }];

	keybindings = let 
	 mod = "Mod4";
	in {
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


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
  ];

  programs.neovim.vimAlias = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

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

