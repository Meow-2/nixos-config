{ stdenv, fetchFromGitHub, pkgs }:

stdenv.mkDerivation rec {
  name = "diodon-${version}";
  version = "1.13.0";
  src = fetchFromGitHub {
    owner = "diodon-dev";
    repo = "diodon";
    rev = "28f2432a2b5a6cce2f456cfe54c9cad118f7f0fc";
    hash = "sha256-FmORxY7SLFnAmtQyC82sK36RoUBa94rJ7BsDXjXUCXk=";
  };

  # mesonFlags = [
  #   "--prefix=$(out)"
  # ];
  nativeBuildInputs = with pkgs; [
    vala
    ninja
    meson
    xvfb-run
    pkg-config
    cmake
  ];
  BuildInputs = with pkgs; [
    gtk3
    zeitgeist
    libpeas
    indicator-application-gtk3
    libev
  ];
}
