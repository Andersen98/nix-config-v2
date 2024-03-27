debug-plasma5:
    nixos-rebuild switch --flake .#lenovo-x270-plasma5-standard --show-trace --impure --use-remote-sudo
debug-sway:
    nixos-rebuild switch --flake .#lenovo-x270-sway-standard --show-trace --impure --use-remote-sudo
