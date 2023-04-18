let
    source = import (fetchTarball "https://github.com/cachix/devenv/archive/v0.6.2.tar.gz");
in
{
  home.packages = [
    (source.default)
  ];
}
