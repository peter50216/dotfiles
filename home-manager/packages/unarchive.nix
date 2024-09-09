{
  stdenv,
  bash,
}:
stdenv.mkDerivation {
  name = "unarchive";
  version = "1.0.0";

  src = ./unarchive.sh;

  buildInputs = [bash];

  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    cp ${./unarchive.sh} $out/bin/unarchive
    chmod +x $out/bin/unarchive
  '';
}
