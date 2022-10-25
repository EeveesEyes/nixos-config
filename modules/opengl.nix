{ ... }: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      # compute
      intel-compute-runtime
      intel-ocl

      # encode/decode
      vaapiIntel
      intel-media-driver
    ];
  };
}
