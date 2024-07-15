let
  module = fetchTarball {
    name = "source";
    url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0-rc1.tar.gz";
    sha256 = "sha256-64lB/NO6AQ6z6EDCemPSYZWX/Qc6Rt04cPia5T5v01g=";
  };
  lixSrc = fetchTarball {
    name = "source";
    url = "https://git.lix.systems/lix-project/lix/archive/2.90.0-rc1.tar.gz";
    sha256 = "sha256-WY7BGnu5PnbK4O8cKKv9kvxwzZIGbIQUQLGPHFXitI0=";
  };
  # This is the core of the code you need; it is an exercise to the
  # reader to write the sources in a nicer way, or by using npins or
  # similar pinning tools.
in
import "${module}/module.nix" { lix = lixSrc; }
