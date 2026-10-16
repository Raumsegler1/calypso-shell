{
  description = "calypso-shell: a Quickshell shell for Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      quickshell,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAll = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s});
    in
    {
      packages = forAll (pkgs: rec {
        calypso-shell = pkgs.callPackage ./nix/package.nix {
          quickshell = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
        default = calypso-shell;
      });
    };
}
