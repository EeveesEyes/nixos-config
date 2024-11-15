{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.fprintd
  ];
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.swaylock = {
  text = ''
    auth sufficient pam_unix.so try_first_pass likeauth nullok
    auth sufficient pam_fprintd.so
    auth include login
  '';
};
}
