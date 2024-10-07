{ pkgs, ... }: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  hardware.graphics.extraPackages = with pkgs; [
      # compute
      intel-compute-runtime
      intel-ocl

      # encode/decode
      # intel-vaapi-driver # collision
      intel-media-driver
    ];
}
