{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/b49c4f87f9db35ec29ab53534890de14dee8d36b";
    nixpkgs-ruby.url = "github:bobvanderlinden/nixpkgs-ruby";
    nixpkgs-ruby.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-ruby, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        ruby = nixpkgs-ruby.lib.packageFromRubyVersionFile {
          file = ./.ruby-version;
          inherit system;
        };
      in
      {
        devShells.default = with pkgs;
          mkShell {
            buildInputs = [
              ruby
              dprint
              tree
              nil
              nixpkgs-fmt
              typos
            ];
          };
      });
}
