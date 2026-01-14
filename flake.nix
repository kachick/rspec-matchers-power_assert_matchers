{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          # Require CC to build io-console
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              # https://github.com/NixOS/nix/issues/730#issuecomment-162323824
              # https://github.com/kachick/dotfiles/pull/228
              bashInteractive
              findutils # xargs
              nixfmt
              nixfmt-tree
              nil

              ruby_3_4
              # Required to build psych via irb dependency
              # https://github.com/kachick/rspec-matchers-power_assert_matchers/issues/122
              # https://github.com/ruby/irb/pull/648
              libyaml

              dprint
              typos
            ];

            # - Don't use direnv for Nix CI
            # - Don't use .bundle/config to avoid setup-ruby and `rake release` mismatch.
            #   See https://github.com/kachick/rspec-matchers-power_assert_matchers/issues/223 for detail
            env.BUNDLE_PATH = "vendor/bundle";
          };
        }
      );
    };
}
