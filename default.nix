self: super: {

# patch cabal-install to *not* create .ghc.environment.* files.

# TODO if patching is getting complicated due to upstream changes in file, then
# use sed...

cabal-install = if (isNull (builtins.match "2.[24].0.0" super.cabal-install.version))
  then super.cabal-install
  else super.cabal-install.overrideAttrs (oldAttrs: rec {
          buildDepends = [ super.patch ];
          patches = [ ./disable-ghc-env.patch ];
        });
}
