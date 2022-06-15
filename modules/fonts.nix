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
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      nerdfonts
      dejavu_fonts
      fira-code
    ];
  };
}
