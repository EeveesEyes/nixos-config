{
    programs.waybar = {
      enable = true;
      settings = [{
        layer = "top";
        position = "bottom";
        height = 28;
        modules-left = [
          "sway/workspaces"
          "sway/window"
        ];
        modules-center = [
        ];
        modules-right = [
          "disk"
          "pulseaudio"
          "network"
          "memory"
          "cpu"
          "temperature"
          "battery"
          "tray"
          "clock"
        ];
        modules = {
          "battery" = {
            states = {
              warning = 20;
              critical = 10;
            };
            format = " {capacity}%";
            format-discharging = "{icon} {capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
          };
          "cpu" = {
            format = "  {}";
          };
          "clock" = {
            format = "{:%H:%M}";
            tooltip = false;
          };
          "memory" = {
            interval = 5;
            format = "  {}%";
            tooltip-format = "{used:0.1f}/{total:0.1f} GB";
            states = {
              warning = 80;
              critical = 90;
            };
          };
          "network" = {
            interface = "wl*";
            format-wifi = "  {essid}";
            format-icons = [
              ""
            ];
            tooltip-format-wifi = "{frequency} MHz, {signaldBm} dBm";
          };
          "pulseaudio" = {
            scroll-step = 1;
            format = "{icon}  {volume}%";
            format-bluetooth = "{icon} {volume}% ";
            format-muted = "";
            format-icons = {
              headphones = "";
              handsfree = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" ];
            };
            on-click = "pavucontrol";
          };
          "sway/workspaces" = {
            all-outputs = false;
            disable-scroll = false;
            format = "{name}";
          };
          "temperature" = {
            format = " {temperatureC}°C";
            hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
            critical-threshold = 75;
          };
          "disk" = {
            interval = 30;
            format = "{free} free";
            path = "/";
          };
        };
      }];
      style = builtins.readFile ./waybar.css;
    };
}
