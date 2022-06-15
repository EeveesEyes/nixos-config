{pkgs, ...}: {
  home.packages = [pkgs.discord];

  home.file.".config/discord/settings.json" = {
    text = builtins.toJSON {
      "BACKGROUND_COLOR" = "#202225";
      "IS_MAXIMIZED" = true;
      "IS_MINIMIZED" = false;
      "SKIP_HOST_UPDATE" = true; # Disables the update check on startup
    };
  };
}
