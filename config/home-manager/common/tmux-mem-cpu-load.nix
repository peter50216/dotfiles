{
  stdenv,
  pkgs,
}:
with pkgs;
  stdenv.mkDerivation {
    pname = "tmux-mem-cpu-load";
    version = "1.0.0";
    src = fetchgit {
      url = "https://peter50216@bitbucket.org/peter50216/tmux-mem-cpu-load.git";
      sha256 = "VIdYup5E+g7t21WxwqFnkzjQPeQiVciHDkkZHlBKxqk=";
      rev = "fd492659b448f07fe23e5286ba2fcf78032b5aa5";
    };
    nativeBuildInputs = [
      clang
      cmake
    ];
    configPhase = "cmake .";
    buildPhase = "make -j $NIX_BUILD_CORES";
    installPhase = ''
      mkdir -p $out/bin
      mv tmux-mem-cpu-load $out/bin
    '';
  }
