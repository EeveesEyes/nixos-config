{ pkgs, ... }:
{
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;

      config = {
        modifier = "Mod4";
        focus.followMouse = false;

        input = {
          "type:keyboard" = { xkb_layout = "eu"; };
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
        gaps = { inner = 8; };
        window.border = 0;
        workspaceAutoBackAndForth = true;
        terminal = "foot";

        bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

        keybindings =
          let
            mod = "Mod4";
            pactl = "${pkgs.pulseaudioLight}/bin/pactl";
            playerctl = "${pkgs.playerctl}/bin/playerctl";
          in
          {
            "${mod}+Return" = "exec foot";
            "${mod}+p" = "exec ${pkgs.wofi}/bin/wofi --show drun";

            "${mod}+Shift+c" = "reload";
            "${mod}+Shift+q" = "kill";
            "${mod}+Shift+e" =
              "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
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

            ## MacroPad
            # Print, Pause, AudioRaiseVolume
            "Print" = "exec grimshot save area";
            "Pause" = "exec systemctl suspend";
            "XF86AudioRaiseVolume" =
              "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
            # Tools, AudioMute, AudioLowerVolume
            "Tools" = "exec swaylock";
            "XF86AudioMute" =
              "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioLowerVolume" =
              "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";

            # AudioPrev, AudioPlay, AudioNext
            "XF86AudioNext" = "exec ${playerctl} next";
            "XF86AudioPlay" = "exec ${playerctl} play-pause";
            "XF86AudioPrev" = "exec ${playerctl} previous";
          };

      };
    };

  }