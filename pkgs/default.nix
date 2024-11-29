# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  plymouth-theme-jar-jar = pkgs.callPackage ./plymouth-theme-jar-jar.nix { };
}
