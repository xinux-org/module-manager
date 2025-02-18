{ pkgs ? import <nixpkgs> { }
, lib ? import <nixpkgs/lib>
}:
pkgs.stdenv.mkDerivation rec {
  pname = "xinux-module-manager";
  version = "0.0.1";

  src = [ ./. ];

  cargoDeps = pkgs.rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "nix-data-0.0.3" = "sha256-+xBbsCI7yYfgnwdDYmydzRlVuMnkFr/KK6xRK1szaLs=";
    };
  };

  nativeBuildInputs = with pkgs; [
    appstream-glib
    polkit
    gettext
    desktop-file-utils
    meson
    ninja
    pkg-config
    git
    wrapGAppsHook4
  ] ++ (with pkgs.rustPlatform; [
    cargoSetupHook
    cargo
    rustc
  ]);

  buildInputs = with pkgs; [
    gdk-pixbuf
    glib
    gtk4
    libadwaita
    libxml2
    openssl
    vte-gtk4
    wayland
    adwaita-icon-theme
    desktop-file-utils
  ];
}
