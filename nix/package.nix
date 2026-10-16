{
  lib,
  stdenvNoCC,
  makeWrapper,
  quickshell,
  networkmanager,
  rofi,
  procps,
  coreutils,
  gnugrep,
}:

stdenvNoCC.mkDerivation {
  pname = "calypso-shell";
  version = "unstable";
  src = lib.cleanSource ./..;

  nativeBuildInputs = [ makeWrapper ];
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/calypso-shell
    cp -r shell.qml components config services widgets $out/share/calypso-shell/

    makeWrapper ${lib.getExe quickshell} $out/bin/calypso-shell \
      --add-flags "-p $out/share/calypso-shell" \
      --prefix PATH : ${
        lib.makeBinPath [
          networkmanager
          rofi
          procps
          coreutils
          gnugrep
        ]
      }

    runHook postInstall
  '';

  meta.mainProgram = "calypso-shell";
}
