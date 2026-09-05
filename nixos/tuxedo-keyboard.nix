#1mpq15yijsvx8pgly04gv07pym08ji4n4cahr36rs5gqz0k46bqv


{ stdenv, lib, fetchFromGitHub, kernel, sysVendor, boardVendor, chassisVendor }:

stdenv.mkDerivation rec {
  pname = "tuxedo-keyboard";
  version = "master";

  src = fetchFromGitHub {
    owner = "wessel-novacustom";
    repo = "clevo-keyboard";
    rev = "master";
    # The hash you just calculated:
    sha256 = "1mpq15yijsvx8pgly04gv07pym08ji4n4cahr36rs5gqz0k46bqv";
  };

  # PATCH: This forces the driver to accept "GIGABYTE" as a valid vendor
  postPatch = ''
    sed -i 's/DMI_MATCH(DMI_SYS_VENDOR, .*)/DMI_MATCH(DMI_SYS_VENDOR, "${sysVendor}")/g' src/tuxedo_keyboard.c
    sed -i 's/DMI_MATCH(DMI_BOARD_VENDOR, .*)/DMI_MATCH(DMI_BOARD_VENDOR, "${boardVendor}")/g' src/tuxedo_keyboard.c
    sed -i 's/DMI_MATCH(DMI_CHASSIS_VENDOR, .*)/DMI_MATCH(DMI_CHASSIS_VENDOR, "${chassisVendor}")/g' src/tuxedo_keyboard.c
  '';

  hardened = false;
  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];

  preBuild = ''
    cd src
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
    cp tuxedo_keyboard.ko $out/lib/modules/${kernel.modDirVersion}/extra/
  '';

  meta = with lib; {
    description = "Tuxedo Keyboard driver (Patched for Gigabyte)";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
