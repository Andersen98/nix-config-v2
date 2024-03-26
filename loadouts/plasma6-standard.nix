{self, nixpkgs, ...}:
{
    imports = [
        ./components/plasma6.nix
        ./components/core-pkgs.nix
        ./components/fhs.nix
        ./components/vscode.nix
    ];

    nixpkgs.config.allowUnfree = true;
}