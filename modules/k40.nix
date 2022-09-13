{
  programs.k40-whisperer = {
    enable = true;
  };

  # Allow access to device via udev rule
  users.users.fleaz.extraGroups = ["k40"];
}
