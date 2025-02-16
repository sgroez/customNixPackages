{ stdenv,
  lib,
  autoPatchelfHook,
  p7zip,
  libGL,
  libgcc,
  freetype,
  alsa-lib,
}:

stdenv.mkDerivation rec {
  pname = "pianoteq";
  version = "0.3";
  file_in = "/nix/store/vmdryva9hywy67avc8nkg2qrn8ix4b6p-pianoteq_stage_linux_v841.7z";

  src = builtins.storePath file_in;

  dontBuild = true;

  nativeBuildInputs = [ autoPatchelfHook p7zip ];
  buildInputs = [ libGL libgcc freetype alsa-lib stdenv.cc.cc.lib ];

  unpackPhase = ''
    7z x ${src}
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 -D 'Pianoteq 8 STAGE'/x86-64bit/'Pianoteq 8 STAGE' $out/bin/${pname}
    install -m755 -D 'Pianoteq 8 STAGE'/x86-64bit/'Pianoteq 8 STAGE.lv2'/Pianoteq_8_STAGE.so $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    description = "Nix pianoteq wrapper.";
    homepage = "https://www.modartt.com/";
    platforms = platforms.unix;
  };
}
