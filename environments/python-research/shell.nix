# shell.nix
let
  # We pin to a specific nixpkgs commit for reproducibility.
  # Last updated: 2024-04-29. Check for new commits at https://status.nixos.org.
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/394571358ce82dff7411395829aa6a3aad45b907.tar.gz") {};

  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
#      zfit = pyfinal.callPackage ./zfit.nix { };
    };
  };

in pkgs.mkShell {
  packages = [
    (python.withPackages (python-pkgs: with python-pkgs; [
      # select Python packages here
      pandas
      numpy
      scipy
      hist
      particle
      uproot
      uv
      ipykernel
      matplotlib
      mplhep
      awkward
#      tensorflow
#      zfit
    ]))
  ];
}
