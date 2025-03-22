{
  description = "OCaml development environment with Dune and LSP";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default =
      nixpkgs.legacyPackages.x86_64-linux.mkShell {
        buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
          ocaml
          dune_3
          opam
          ocamlPackages.ocaml-lsp
          ocamlPackages.utop
          ocamlPackages.ocamlformat
          ocamlPackages.ocp-indent
          binutils
        ];
      };
  };
}
