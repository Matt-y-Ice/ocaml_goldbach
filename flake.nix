{
  description = "OCaml development environment with Dune and LSP";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default =
      nixpkgs.legacyPackages.x86_64-linux.mkShell {
        buildInputs = [
          nixpkgs.legacyPackages.x86_64-linux.ocaml
          nixpkgs.legacyPackages.x86_64-linux.dune_3
          nixpkgs.legacyPackages.x86_64-linux.ocamlPackages.merlin
          nixpkgs.legacyPackages.x86_64-linux.ocamlPackages.ocaml-lsp
          nixpkgs.legacyPackages.x86_64-linux.ocamlPackages.utop
          nixpkgs.legacyPackages.x86_64-linux.ocamlPackages.ocamlformat
          nixpkgs.legacyPackages.x86_64-linux.binutils
        ];
      };
  };
}
