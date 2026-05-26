{
  inputs = {
    nixpkgs.url = "git+https://git.oss.uzinfocom.uz/xinux/nixpkgs?ref=nixos-unstable&shallow=1";
    xinux-lib = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/lib?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs:
    inputs.xinux-lib.mkFlake {
      inherit inputs;
      alias.packages.default = "xinux-module-manager";
      alias.shells.default = "xinux-module-manager";
      src = ./.;
      hydraJobs = {
        inherit (self.packages.x86_64-linux) default;
      };
    };
}
