{ stdenv,
  lib,
  fetchurl,
  makeDesktopItem,
  copyDesktopItems,
  autoPatchelfHook,
  p7zip,
  libGL,
  libgcc,
  freetype,
  alsa-lib,
}:

stdenv.mkDerivation rec {
  pname = "pianoteq8";
  version = "8.4.1";
  file_in = "/nix/store/vmdryva9hywy67avc8nkg2qrn8ix4b6p-pianoteq_stage_linux_v841.7z";
  
  src = builtins.storePath file_in;

  icon = fetchurl {
    name = "pianoteq_icon_128";
    url = "https://www.pianoteq.com/images/logo/pianoteq_icon_128.png";
    sha256 = "sha256-lO5kz2aIpJ108L9w2BHnRmq6wQP+6rF0lqifgor8xtM=";
  };

  desktopItems = [
    (makeDesktopItem {
      name = "pianoteq8";
      desktopName = "Pianoteq 8";
      exec = "pianoteq8";
      icon = "pianoteq_icon_128";
    })
  ];

  dontBuild = true;

  nativeBuildInputs = [ autoPatchelfHook p7zip copyDesktopItems ];
  buildInputs = [ libGL libgcc freetype alsa-lib stdenv.cc.cc.lib ];

  unpackPhase = ''
    7z x ${src}
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r -p 'Pianoteq 8 STAGE'/x86-64bit/* $out/bin/
    cd $out/bin
    mv 'Pianoteq 8 STAGE' pianoteq8
    runHook postInstall
  '';

  postInstall = ''
    install -Dm 444 ${icon} $out/share/icons/hicolor/128x128/apps/pianoteq_icon_128.png
  '';

  meta = with lib; {
    description = "Pianoteq is a virtual instrument which in contrast to other virtual instruments is physically modelled and thus can simulate the playability and complex behaviour of real acoustic instruments. Because there are no samples, the file size is just a tiny fraction of that required by other virtual instruments.";
    homepage = "https://www.modartt.com/";
    platforms = platforms.unix;
    maintainers = [ sgroez ];
  };
}
