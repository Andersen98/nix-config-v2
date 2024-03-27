debug-lenovo:
    nixos-rebuild switch --flake .#lenovo-x270-plasma5-standard --show-trace --impure --use-remote-sudo
