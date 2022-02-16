{ pkgs, ... }: {
  fonts = {
    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      defaultFonts = {
        monospace = [ "Fira Code" "Source Code Pro" "Roboto Mono" "DejaVu Sans Mono" ];
        sansSerif = [ "Roboto Regular" "DejaVu Sans" ];
        serif = [ "Roboto Slab Regular" "DejaVu Serif" ];
      };
    };
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      fira-code
      google-fonts
      inconsolata
      iosevka
      liberation_ttf
      nerdfonts
      roboto
      source-code-pro
      ubuntu_font_family
    ];
  };
}
