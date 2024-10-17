let
  source = import (fetchTarball {
    name = "source";
    url = "https://github.com/cachix/devenv/archive/v1.3.tar.gz";
    sha256 = "sha256:1p83nxqm82q3xd58wl34iwpzpxrip9rfqrz11kc6kvvjwl8nm26p";
  });
in
{
  home.packages = [
    (source)
  ];
}
