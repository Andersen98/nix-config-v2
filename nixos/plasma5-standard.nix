{self, nixpkgs, ...}:
{
    imports = [
        ./components/plasma5.nix
        ./components/core-pkgs.nix
        ./components/fhs.nix
        ./components/vscode.nix
        ./components/mk-fish-default.nix
    ];

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
