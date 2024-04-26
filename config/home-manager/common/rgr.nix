{
  stdenv,
  pkgs,
}:
with pkgs;
  stdenv.mkDerivation {
    pname = "rgr";
    version = "1.0.0";
    src = fetchgit {
      url = "https://github.com/peter50216/ripgrep_replace.git";
      sha256 = "sha256-XXUBilB0ixry/lfpEVqMGcRmgLtCAUq7aGSUVtHIybI=";
      rev = "68ab346ebc5b52d38a32a09aecb4d1e2cc844145";
    };
    installPhase = ''
      mkdir -p $out/bin
      mv rgr.sh $out/bin/rgr
    '';
  }
