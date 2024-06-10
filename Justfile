debug-lenovo-plasma5:
    nixos-rebuild switch --flake .#lenovo-x270-plasma5 --show-trace --impure --use-remote-sudo
debug-lenovo-sway:
    nixos-rebuild switch --flake .#lenovo-x270-sway --show-trace --impure --use-remote-sudo
debug-x570-plasma5:
    nixos-rebuild switch --flake .#x570-plasma5 --show-trace --impure --use-remote-sudo
debug-x570-sway:
    nixos-rebuild switch --flake .#x570-sway --show-trace --impure --use-remote-sudo
