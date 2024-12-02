{
  pkgs,
  ...
}:

{
  boot.kernelParams = [
    # Disable "Panel Self Refresh".  Fix random freezes.
    "i915.enable_psr=0"
  ];  
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
   hardware.graphics = { # hardware.graphics on unstable
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
      intel-media-sdk # lenovo x270 has a Kaby Lake Intel CPU Kaby lake is legacy and uses Intel Media SDK for QSV
    ];
  };
  hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "i965"; }; # Force intel-media-driver
}
