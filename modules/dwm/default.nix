{ stdenv, fetchgit, pkgs }:

stdenv.mkDerivation rec {
  name = "dwm-${version}";
  version = "6.3";
  src = (fetchgit {
    url = "git@github.com:Meow-2/dwm.git";
    fetchSubmodules = true;
    sha256 = "QoC7/xdRHmsIVdm7yhwHZtwugAXCjPaSxbg4GYkSKe8=";
  }).overrideAttrs
    {
      GIT_CONFIG_COUNT = 1;
      GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
      GIT_CONFIG_VALUE_0 = "git@github.com:";
    };
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ xorg.libX11 xorg.libXft xorg.libXinerama xorg.xcbutil gcc ];
  makeFlags = [ "PREFIX=$(out)" ];
}
