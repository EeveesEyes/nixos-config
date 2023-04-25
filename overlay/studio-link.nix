{ stdenv
, lib
, fetchurl
, pulseaudio
, zlib
, alsaLib
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "studio-link";
  version = "21.07.0";

  src = fetchurl {
    url = "https://download.studio.link/releases/v${version}-stable/linux/studio-link-standalone-v${version}.tar.gz";
    hash = "sha256-4CkijAlenhht8tyk3nBULaBPE0GBf6DVII699/RmmWI=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    autoPatchelfHook
  ];
  
  buildInputs = [
    alsaLib
    pulseaudio
    zlib
  ];
  
  installPhase = ''
    install -D -m755 studio-link-standalone-v* $out/bin/studio-link
  '';

  meta = with lib; {
    homepage = "https://studio-link.com";
    description = "VoIP Thing";
    platforms = platforms.linux;
  };
}
