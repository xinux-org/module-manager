{
  inputs = {
    nixpkgs.url = "github:xinux-org/nixpkgs/nixos-unstable";
    xinux-lib = {
      url = "github:xinux-org/lib";
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
