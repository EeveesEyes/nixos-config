{
  nix.gc = {
    automatic = false;
    dates = "weekly";
    options = "--delete-older-than 100d";
  };
}
