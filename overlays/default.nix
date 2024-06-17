# This file defines overlays
{inputs}:
[
  # This one brings our custom packages from the 'pkgs' directory
  #additions
  (final: prev: (import ../pkgs) {inherit (prev) pkgs; inherit inputs;})

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  #modifications  
  (final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  })

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  #unstable-packages
  (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = prev.system;
      config.allowUnfree = true;
    };
  })


  # You can also add overlays exported from other flakes:
  # neovim-nightly-overlay.overlays.default
  inputs.neorg-overlay.overlays.default
  inputs.neovim-nightly-overlay.overlays.default

  # Or define it inline, for example:
  # (final: prev: {
  #   hi = final.hello.overrideAttrs (oldAttrs: {
  #     patches = [ ./change-hello-to-hi.patch ];
  #   });
  # })
]
