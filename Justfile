debug-lenovo-plasma5:
    nixos-rebuild switch --flake .#lenovo-x270-plasma5-standard --show-trace --impure --use-remote-sudo
debug-lenovo-sway:
    nixos-rebuild switch --flake .#lenovo-x270-sway-standard --show-trace --impure --use-remote-sudo
debug-x570-plasma5:
    nixos-rebuild switch --flake .#x570-plasma5-standard --show-trace --impure --use-remote-sudo
debug-x570-sway:
    nixos-rebuild switch --flake .#x570-sway-standard --show-trace --impure --use-remote-sudo
