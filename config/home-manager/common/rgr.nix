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
      sha256 = "sha256-IaDYYDXhscOP7tHJdtl4ZZgwTO/Cnpjl5XdJKOnX1Ls=";
      rev = "74ff509623bc58aed0835a9ebb19dd4bcd70e32a";
    };
    installPhase = ''
      mkdir -p $out/bin
      mv rgr.sh $out/bin/rgr
    '';
  }
