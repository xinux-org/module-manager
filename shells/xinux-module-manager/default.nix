{
  pkgs,
  inputs,
  system,
  mkShell,
  cargo,
  clippy,
  desktop-file-utils,
  rust-analyzer,
  rustc,
  rustfmt,
  cairo,
  gdk-pixbuf,
  gobject-introspection,
  graphene,
  gtk4,
  libadwaita,
  libxml2,
  meson,
  ninja,
  openssl,
  pkg-config,
  polkit,
  vte-gtk4,
  wrapGAppsHook4,
  ...
}:
let
  treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs {
    projectRootFile = "flake.nix";
    programs.nixfmt.enable = true;
    programs.rustfmt.enable = true;
  };
  preCommitCheck = inputs.git-hooks.lib."${system}".run {
    src = ./.;
    hooks.treefmt.enable = true;
    hooks.treefmt.package = treefmtEval.config.build.wrapper;
  };
in
mkShell {
  buildInputs = with pkgs; [
    cargo
    clippy
    desktop-file-utils
    rust-analyzer
    rustc
    rustfmt
    cairo
    gdk-pixbuf
    gobject-introspection
    graphene
    gtk4
    libadwaita
    libxml2
    meson
    ninja
    openssl
    pkg-config
    polkit
    vte-gtk4
    wrapGAppsHook4
  ];

  RUST_BACKTRACE = 1;
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  shellHook = preCommitCheck.shellHook;
}
