let
    source = import (fetchTarball "https://github.com/cachix/devenv/archive/v1.0.5.tar.gz");
in
{
  home.packages = [
    (source.default)
  ];
}
