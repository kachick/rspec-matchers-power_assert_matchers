{
  inputs = {
    # Candidate channels
    #   - https://github.com/kachick/anylang-template/issues/17
    #   - https://discourse.nixos.org/t/differences-between-nix-channels/13998
    # How to update the revision
    #   - `nix flake update --commit-lock-file` # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake-update.html
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    selfup = {
      url = "github:kachick/selfup/v1.1.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      selfup,
    }:
    let
      inherit (nixpkgs) lib;
      # List: https://github.com/NixOS/nixpkgs/blob/nixos-24.05/lib/systems/flake-systems.nix
      #
      # https://github.com/NixOS/nixpkgs/blob/475556854559746466df20d74eef189373816b67/flake.nix?plain=1#L11
      # https://github.com/NixOS/nixpkgs/blob/475556854559746466df20d74eef189373816b67/lib/systems/default.nix?plain=1#L48-L56
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs =
              (with pkgs; [
                # https://github.com/NixOS/nix/issues/730#issuecomment-162323824
                # https://github.com/kachick/dotfiles/pull/228
                bashInteractive
                findutils # xargs
                nixfmt-rfc-style
                nil

                ruby_3_3
                # Required to build psych via irb dependency
                # https://github.com/kachick/rspec-matchers-power_assert_matchers/issues/122
                # https://github.com/ruby/irb/pull/648
                libyaml

                dprint
                typos
              ])
              ++ [ selfup.packages.${system}.default ];
          };
        }
      );
    };
}
