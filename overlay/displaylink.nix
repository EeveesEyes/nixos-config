(
  final: prev:
  let
    version = "6.1.0";
    # Replace URL + sha256 with the exact upstream zip and the sha256 you get from nix-prefetch-url.
    # nix-prefetch-url --name displaylink-610.zip https://www.synaptics.com/sites/default/files/exe_files/2024-10/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1-EXE.zip
    # nix-prefetch-url --name displaylink-611.zip https://www.synaptics.com/sites/default/files/exe_files/2025-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.1.1-EXE.zip
    # nix-prefetch-url --name displaylink-620.zip https://www.synaptics.com/sites/default/files/exe_files/2025-09/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.2-EXE.zip
    url = "https://www.synaptics.com/sites/default/files/exe_files/2025-09/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.2-EXE.zip";
    sha256 = "1b3w7gxz54lp0hglsfwm5ln93nrpppjqg5sfszrxpw4qgynib624";
  in
  {
    displaylink = prev.displaylink.overrideAttrs (old: {
      src = final.fetchurl {
        url = url;
        sha256 = sha256;
      };
      version = version;
    });
  }
)
