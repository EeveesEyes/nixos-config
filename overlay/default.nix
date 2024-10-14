self: super: {
  nerdfonts = super.nerdfonts.override {
    fonts = [
      "DroidSansMono"
      "FiraCode"
      "FiraMono"
      "Inconsolata"
      "Iosevka"
      "Meslo"
    ];
  };
}
