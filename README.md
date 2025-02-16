# Custom nix derivations for non free software
## Installation
1. Run the build.sh inside the package folder to build the package.
2. Add following lines to nixos configuration.
```
nixpkgs.config.packageOverrides = pkgs: {
  <package> = pathToRepo/<package>/default.nix { };
};
```
3. Then add your package to your system package list like any other package.
