# Custom nix derivations for non free software
## Installation
1. Change into the directory of the package you want to install
2. Run the following command to build the package
```
nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'
```
3. Add following lines to nixos configuration.
```
nixpkgs.config.packageOverrides = pkgs: {
  <package> = pathToRepo/<package>/default.nix { };
};
```
4. Then add your package to your system package list like any other package.
