{ pkgs, ... }: {
  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      defaultFonts = {
        monospace = [ "Fira Code" "DejaVu Sans Mono" ];
        sansSerif = [ "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
      };
    };
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.droid-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      dejavu_fonts
      fira-code
    ];
  };
}