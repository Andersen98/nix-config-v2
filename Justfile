droid-a:
    nix-on-droid switch --flake .#a
lenovo-other-e:
  nixos-rebuild switch --flake .#lenovo-x270-other-e --show-trace --impure --use-remote-sudo
lenovo-plasma5-d:
    nixos-rebuild switch --flake .#lenovo-x270-plasma5-d --show-trace --impure --use-remote-sudo
lenovo-sway-d:
    nixos-rebuild switch --flake .#lenovo-x270-sway-d --show-trace --impure --use-remote-sudo
x570-plasma5-d:
    nixos-rebuild switch --flake .#x570-plasma5-d --show-trace --impure --use-remote-sudo
x570-plasma6-d:
    nixos-rebuild switch --flake .#x570-plasma6-d --show-trace --impure --use-remote-sudo
x570-sway-d:
    nixos-rebuild switch --flake .#x570-sway-d --show-trace --impure --use-remote-sudo
pink-pc-sway-c:
    nixos-rebuild switch --flake .#pink-pc-sway-c --show-trace --impure --use-remote-sudo
pink-pc-plasma5-d:
    nixos-rebuild switch --flake .#pink-pc-plasma5-d --show-trace --impure --use-remote-sudo
