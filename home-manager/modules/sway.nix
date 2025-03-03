{ pkgs, nixosConfig, lib, ... }:
let
  lockCmd = "${pkgs.swaylock}/bin/swaylock -i /etc/nixos/wallpaper.png";
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    # Sway can't find wallpaper.jpg and failes to build
    # https://discourse.nixos.org/t/sway-fails-with-cannot-create-gles2-renderer-after-update/45703/2
    checkConfig = false;

    config = {
      modifier = "Mod4";
      focus.followMouse = false;

      input = {
        "type:keyboard" = { xkb_layout = "eu"; };
        "type:mouse" = { pointer_accel = "-1"; };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "1:1:AT_Translated_Set_2_keyboard" = {
          # Remap borken ctrl key on internal keyboard for XPS
          # xkb_options = "caps:ctrl_modifier";
        };
      };
      output = {
        "*".bg = "/etc/nixos/wallpaper.png fill";
      } // lib.optionalAttrs (nixosConfig.networking.hostName == "hakuto") {
        "eDP-1" = {
          mode = "2880x1920@59.951Hz";
          scale = "1.5";
          position = "2900,1440";
        };
        "Ancor Communications Inc ASUS MG278 0x0001D4B3" = {
          mode = "2560x1440@59.951Hz";
          scale = "1";
          position = "2560,0";
        };
        "Iiyama North America PL2792Q 1152180402418" = {
          mode = "2560x1440@59.951Hz";
          scale = "1";
          position = "0,0";
        };
      };

      gaps = { inner = 5; };
      window.border = 2;
      window.hideEdgeBorders = "smart";
      workspaceAutoBackAndForth = true;
      terminal = "foot";

      colors = {
        focused = {
          border = "#fe8019";
          background = "#285577";
          text = "#ffffff";
          indicator = "#2e9ef4";
          childBorder = "#fe8019";
        };
        focusedInactive = {
          border = "#333333";
          background = "#5f676a";
          text = "#ffffff";
          indicator = "#484e50";
          childBorder = "#ebdbb2";
        };
        unfocused = {
          border = "#333333";
          background = "#222222";
          text = "#888888";
          indicator = "#292d2e";
          childBorder = "#5f676a";
        };
        urgent = {
          border = "#fabd2f";
          background = "#900000";
          text = "#ffffff";
          indicator = "#900000";
          childBorder = "#900000";
        };
        placeholder = {
          border = "#000000";
          background = "#0c0c0c";
          text = "#ffffff";
          indicator = "#000000";
          childBorder = "#0c0c0c";
        };
      };

      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      startup = [
        {
          command = ''${pkgs.swayidle}/bin/swayidle -w \
                           timeout 600 "${lockCmd}" \
                           timeout 900 "${pkgs.sway}/bin/swaymsg output * dpms off" \
                                resume "${pkgs.sway}/bin/swaymsg output * dpms on" \
                           before-sleep "${lockCmd}"'';
        }
        { command = ''sway-audio-idle-inhibit''; }
      ];
      #   timeout 600 "${lockCmd}" \

      # █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
      # █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█

      keybindings =
        let
          mod = "Mod4";
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          playerctl = "${pkgs.playerctl}/bin/playerctl";
        in
        {
          "${mod}+Return" = "exec foot";
          "${mod}+d" = "exec ${pkgs.wofi}/bin/wofi --show drun --gtk-dark";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+q" = "kill";
          "${mod}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

          "${mod}+s" = "split v";
          "${mod}+w" = "split h";
          /*
            bind = $mainMod, E, exec, $file # launch file manager
          */

          "${mod}+t" = "layout tabbed";
          "${mod}+r" = "mode resize";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+space" = "floating toggle";

          # Workspace controls focus
          "${mod}+left" = "focus left";
          "${mod}+h" = "focus left";
          "${mod}+down" = "focus down";
          "${mod}+j" = "focus down";
          "${mod}+up" = "focus up";
          "${mod}+k" = "focus up";
          "${mod}+right" = "focus right";
          "${mod}+l" = "focus right";
          "alt+tab" = "focus right";
          "alt+shift+tab" = "focus left";

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
          # Switch workspaces to a relative workspace
          "${mod}+alt+Right" = "workspace r+1";
          "${mod}+alt+Left" = "workspace r-1";
          # Scroll through existing workspaces
          #"${mod}+mouse_down" = "workspace e+1"; # unknown key or button mouse_up
          #"${mod}+mouse_up" = "workspace e-1";

          # Move/Switch to special workspace (scratchpad)
          "${mod}+alt+o" = "move container to scratchpad";
          "${mod}+o" = "scratchpad show";

          # Move things
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

          "${mod}+ctrl+left" = "move workspace to output left";
          "${mod}+ctrl+h" = "move workspace to output left";
          "${mod}+ctrl+down" = "move workspace to output down";
          "${mod}+ctrl+j" = "move workspace to output down";
          "${mod}+ctrl+up" = "move workspace to output up";
          "${mod}+ctrl+k" = "move workspace to output up";
          "${mod}+ctrl+right" = "move workspace to output right";
          "${mod}+ctrl+l" = "move workspace to output right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+left" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+down" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+up" = "move up";
          "${mod}+Shift+l" = "move right";
          "${mod}+Shift+right" = "move right";
          "${mod}+Shift+ J" = "togglesplit";

          ## MacroPad
          # Print, Pause, AudioRaiseVolume
          "Print" = "exec grimshot copy area";
          "${mod}+ctrl+Escape" = "exec systemctl suspend";
          "XF86AudioRaiseVolume" =
            "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
          # Tools, AudioMute, AudioLowerVolume
          "XF86Tools" = "exec ${lockCmd}";
          "XF86AudioMute" =
            "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioLowerVolume" =
            "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";

          # AudioPrev, AudioPlay, AudioNext
          "XF86AudioNext" = "exec ${playerctl} next";
          "XF86AudioPlay" = "exec ${playerctl} play-pause";
          "XF86AudioPrev" = "exec ${playerctl} previous";

          # Laptop Brightness controll
          "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +10%";
          "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-";

          # Lockscreen on laptop
          "${mod}+Escape" = "exec ${lockCmd}";
        };
    };
  };
  # libinput-gestures = {
  #   enable = true;
  #   config = {
  #         # gestures
  #         "gesture: swipe up" = "volumectl +1%";
  #         "gesture: swipe down" = "volumectl -1%";
  #         "gesture: swipe 3 left" = "swaymsg workspace prev";
  #         "gesture: swipe 3 right" = "swaymsg workspace next";
  #         "gesture: swipe 2 left"= "_internal alt+Left";
  #         "gesture: swipe 2 right"= "_internal alt+Right";
  #   };
  # };
}
