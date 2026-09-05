{ stdenv, lib, fetchFromGitHub, kernel }:

stdenv.mkDerivation rec {
  pname = "clevo-xsm-wmi";
  version = "run-2024-12-22";

  src = fetchFromGitHub {
    owner = "quitesimple";
    repo = "clevo-xsm-wmi-preserved";
    rev = "9532654305c4873995f5147573907c08a9582ee6";
    sha256 = "sha256-vS1GDtn1/wb2suaQhOa6D/Dr/V67wL3zVbzF6V89sT0=";
  };

  sourceRoot = "${src.name}/module";
  hardened = false;
  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];

  installPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) modules_install INSTALL_MOD_PATH=$out
  '';

  meta = with lib; {
    description = "Kernel module for Clevo XSM WMI (Preserved Fork)";
    license = licenses.gpl2;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
