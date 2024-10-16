{ pkgs, config, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  colorScheme = nix-colors.colorSchemes.dracula;

  wayland.windowManager.sway.config.programs = {   
      colors = {
        focused = {
          border = "#${config.colorScheme.palette.base01}";
          background = "#${config.colorScheme.palette.base02}";
          text = "#${config.colorScheme.palette.base03}";
          indicator = "#${config.colorScheme.palette.base04}";
          childBorder = "#${config.colorScheme.palette.base05}";
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
  };
}