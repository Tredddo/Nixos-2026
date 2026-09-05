{lib, ...}:

{
  boot.blacklistedKernelModules = lib.mkDefault ["i915"];
  boot.kernelParams = lib.mkDefault ["i915.modeset=0"];
}
