# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./nointel.nix
    ];

  # Only 3 version of the kernel are allowed.
  boot.loader.systemd-boot.configurationLimit = 3;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.kernel.sysctl."zswap.enable" = true;
  #boot.kernel.sysctl."zswap.compressor" = "lz4";
  #boot.kernel.sysctl."zswap.zpool" = "z3fold";

#boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_stable;
#boot.kernelPackages = pkgs.linuxPackages_lqx;

/*
boot.extraModulePackages = [
  config.boot.kernelPackages.tuxedo-drivers
  config.boot.kernelPackages.tuxedo-keyboard
  #config.boot.kernelPackages.clevo-xsm-wmi
  (config.boot.kernelPackages.callPackage ./keyboard.nix { })
  (config.boot.kernelPackages.callPackage ./tuxedo-keyboard.nix {
      sysVendor = "GIGABYTE";
      boardVendor = "GIGABYTE";
      chassisVendor = "GIGABYTE";
    })
];

boot.extraModprobeConfig = ''
    options tuxedo_keyboard force_kbd_type=1
  '';

boot.kernelModules = ["tuxedo_keyboard" "clevo-xsm-wmi"];
*/

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;

networking.firewall.enable = true;
networking.firewall.allowedTCPPorts = [ 8000 8080 ];

  # Abilita VirtualBox
  # virtualisation.virtualbox.host.enable = true;

  # (Opzionale ma altamente consigliato) Abilita l'Extension Pack per supporto USB, ecc.
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  # Cerca la definizione del tuo utente e aggiungi "vboxusers" agli extraGroups
  # users.users.tuo_nome_utente = {
  #  isNormalUser = true;
  #  extraGroups = [ "wheel" "vboxusers" ]; # Assicurati che "vboxusers" sia presente
  #};

#### ---> RETE VMs
# networking.networkmanager = {
#     enable = true;
#     unmanaged = [ "tap0" "br0" ];
#   };
# 
#   systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";
#   systemd.network = {
#     enable = true;
#     wait-online.enable = false;
#     netdevs = {
#       # Create the tap interface
#       "20-tap2" = {
#        enable = true;
#         netdevConfig = {
#           Kind = "tap";
#           Name = "tap2";
#         };
#       };
#       "20-tap3" = {
#        enable = true;
#         netdevConfig = {
#           Kind = "tap";
#           Name = "tap3";
#         };
#       };
#       "20-bridge0" = {
#         enable = true;
#         netdevConfig = {
#           Kind = "bridge";
#           Name = "br0";
#         };
#       };
#     };
#     networks = {
#       "30-enp5s0" = {
#         matchConfig.Name ="enp5s0";
#         linkConfig = {
#           Unmanaged = "yes";
#         };
#       };
#       "40-tap2" = {
#         matchConfig.Name ="tap2";
#         bridgeConfig = {   };
#         linkConfig = {
#           ActivationPolicy = "always-up";
#           RequiredForOnline = "no";
#         };
#         networkConfig = {
#           Bridge = "br0";
#         };
#       };
#       "40-tap3" = {
#         matchConfig.Name ="tap3";
#         bridgeConfig = {   };
#         linkConfig = {
#           ActivationPolicy = "always-up";
#           RequiredForOnline = "no";
#         };
#         networkConfig = {
#           Bridge = "br0";
#         };
#       };
#       "40-bridge0" = {
#         matchConfig.Name = "br0";
#         linkConfig = {
#           ActivationPolicy = "always-up";
#           RequiredForOnline = "no";
#         };
#         networkConfig = {
#           Address = ["192.168.100.1/24"];
#           # Bridge = "br0";
#         };
#       };
#     };
#   };

 

  # Set your time zone.
  time.timeZone = "Europe/Rome";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

/*
nix = {
  settings = {
    cores = 8;
  };
};
*/


#--> BUDGIE DE

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable the Budgie Desktop environment.
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.budgie.enable = true;
  #services.xserver.windowManager.hyprland.enable = true;

###
###
###



#--> POWER MANAGEMENT

  # Thermald proactively prevents overheating on Intel CPUs and works well with other tools
  services.thermald.enable = true;

services.power-profiles-daemon.enable = false;

services.auto-cpufreq.enable = true;
services.auto-cpufreq.settings = {
  battery = {
     governor = "powersave";
     turbo = "never";
  };
  charger = {
     governor = "performance";
     turbo = "auto";
  };
};

  # auto-cpufreq
#  services.auto-cpufreq.enable = true;
#  services.auto-cpufreq.settings = {
#    battery = {
#      governor = "powersave";
#      turbo = "never";
#    };
#
#    charger = {
#     governor = "performance";
#     turbo = "auto";
#    };
#  };

services.tlp = {
      enable = true;
      settings = {
#        CPU_SCALING_GOVERNOR_ON_AC = "performance";
#        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
#
#        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
#        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
#
#        CPU_MIN_PERF_ON_AC = 0;
#        CPU_MAX_PERF_ON_AC = 100;
#        CPU_MIN_PERF_ON_BAT = 0;
#        CPU_MAX_PERF_ON_BAT = 20;
#
       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 30; # 40 and below it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 50; # 80 and above it stops charging

      };
};

###
###
###



 # Environment
  #home.sessionVariables = {
    #EDITOR = "nvim";
    #BROWSER = "firefox";
    #TERMINAL = "kitty";
  #};

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  # Wayland in Plasma and SDDM
  services.displayManager.defaultSession = "plasma";
  services.displayManager.sddm.wayland.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "it2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  #services.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    #alsa.support32Bit = true;
    #pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tb = {
    isNormalUser = true;
    description = "TB";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


#--> External disk

  fileSystems."/mnt/crucial" = {
    device = "/dev/disk/by-uuid/xyz";
    fsType = "btrfs";
    options = [
      "defaults"
      "nofail"
      "compress=zstd:3"
      "discard=async"
      "ssd"
    ];
  };


#--> RAM [SWAP]

zramSwap = {
  enable = true;
  algorithm = "lz4";
  # This refers to the uncompressed size, actual memory usage will be lower.
  memoryPercent = 80;
};


#--> BTRFS

  # Scrub timer for Btrfs
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  # Balance timer for Btrfs
  systemd.services.btrfs-balance = {
    description = "Btrfs balance periodico per liberare chunk vuoti";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.btrfs-progs}/bin/btrfs balance start -dusage=10 /";
    };
  };

  systemd.timers.btrfs-balance = {
    description = "Timer mensile per Btrfs balance";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "monthly";
      Persistent = true;
    };
  };

  # fstrim for NVMe
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };



  programs.command-not-found.enable = true;

  # Install firefox.
  programs.firefox.enable = true;
  #programs.waybar.enable = true;

  #programs.kitty.enable = true



  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.nvidia.acceptLicense = true;


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  services.twingate.enable = true;


#networking.firewall = rec {
#  allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
#  allowedUDPPortRanges = allowedTCPPortRanges;
#};

#networking.firewall.allowedTCPPorts = [ 8001 ];
#networking.firewall = rec {
#  allowedTCPPortRanges = [ { from = 8000; to = 8001; } ];
#  allowedUDPPortRanges = allowedTCPPortRanges;
#};


#nixpkgs.config.packageOverrides = self : rec {
#  blender = self.blender.override {
#    cudaSupport = true;
#  };
#};

#services.ollama = {
#  enable = true;
#  #package = (import <nixos-unstable> { config = config.nixpkgs.config; }).ollama;
#  package = (import <nixos-unstable> { config = config.nixpkgs.config; }).ollama.override { acceleration = "cuda"; };
#  acceleration = "cuda"; # Forza l'uso di CUDA
#  environmentVariables = {
#    OLLAMA_DEBUG = "1"; # Ti aiuterà a vedere meglio cosa succede nei log
#    CUDA_VISIBLE_DEVICES = "0"; 
#  };
#};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nix-output-monitor

    hyprland
    waybar
    wofi
    libnotify
    yad
    #nvidia_oc

    #(python3.withPackages (ps: [ ps.psutils ]))

    tuxedo-rs
    lenovo-legion
    avell-unofficial-control-center
    #xorg-rgb
    brightnessctl
    framework-tool
    xset
    openrgb-with-all-plugins
    
    #linuxKernel.packages.linux_zen.hid-ite8291r3
    #linuxKernel.packages.linux_xanmod_stable.hid-ite8291r3
    #linuxKernel.packages.linux_xanmod_latest.hid-ite8291r3
    #linuxKernel.packages.linux_xanmod.hid-ite8291r3
    #linuxKernel.packages.linux_lqx.hid-ite8291r3
    #linuxKernel.packages.linux_libre.hid-ite8291r3
    #linuxKernel.packages.linux_latest_libre.hid-ite8291r3
    #linuxKernel.packages.linux_hardened.hid-ite8291r3
    #linuxKernel.packages.linux_6_6_hardened.hid-ite8291r3
    #linuxKernel.packages.linux_6_6.hid-ite8291r3
    #linuxKernel.packages.linux_6_1_hardened.hid-ite8291r3
    #linuxKernel.packages.linux_6_16.hid-ite8291r3
    #linuxKernel.packages.linux_6_15.hid-ite8291r3
    #linuxKernel.packages.linux_6_12_hardened.hid-ite8291r3
    #linuxKernel.packages.linux_xanmod.tuxedo-drivers

    git
    appimage-run
    ffmpeg-full
    obs-studio
    gnumake
    moonlight-qt
    supergfxctl
    hwinfo
    vim-full # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    baobab
    zathura
    termius
    #pidgin
    #nuclear
    #spotube

    #bumblebee

    gcc

    #vscode

    #python314Full
    #python313Packages.pip
    SDL2
    pkg-config
    freetype
    #zulu25
    maven
    #jetbrains.idea-ultimate
    (llama-cpp.override { cudaSupport = true; })
    jdk17
    android-tools

    #lutris
    vlc
    gpp
    kitty
    lshw
    #kdePackages.kdeconnect-kde
    #steam
    #unigine-heaven
    inxi
    unityhub
    blender
    yt-dlp
    lm_sensors
    #ollama
    qemu_full
    qemu
    quickemu
    ani-cli
    caffeine-ng
    unrar
    tlp
    obsidian
    gimp
    onlyoffice-desktopeditors
    libreoffice
    prismlauncher

    # Webapp
    invidious

    # Cybersec
    mitmproxy
    #burpsuite
    sleuthkit
    sherlock
    wireshark
    netcat
    nmap
    virtualbox
    #linuxKernel.packages.linux_zen.tuxedo-drivers
    #rustdesk

    sqlitebrowser
    #dotnet-sdk_9
  ];

  # Alias globali per tutti gli utenti
  environment.shellAliases = {

    vita = "vim ~/tblog/vita.txt"; 

    redit = "sudo vim /etc/nixos/configuration.nix";
    redbull = "sudo nixos-rebuild switch";
    redboot = "sudo nixos-rebuild boot";
    redv = "sudo nixos-rebuild switch |& nom";

    redchup = "sudo nix-channel --update";
    redup = "sudo nixos-rebuild switch --update";
    redp = "sudo nix-channel --update && nixos-rebuild switch --update";

    scan = "nmap 192.168.1.0/24";

    windows = "echo 10CORE_7GBram && qemu-system-x86_64 -m 7G -cpu host -enable-kvm -smp 10 -hda win11 -boot d -device virtio-net-pci -vga virtio";
    server = "quickemu --vm ubuntu-server-25.10.conf";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?




#--> ./bin EXTRA LIB

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
stdenv.cc.cc
        #openssl
        #xorg.libXcomposite
        #xorg.libXtst
        #xorg.libXrandr
        #xorg.libXext
        #xorg.libX11
        #xorg.libXfixes
        libxcomposite
        libxtst
        libxrandr
        libxext
        libx11
        libxfixes

        libGL
        libva
        #pipewire.lib
        libxcb
        libXdamage
        libxshmfence
        libXxf86vm
        libelf
        
        # Required
        glib
        gtk2
        bzip2
        #xorg.libgtk

        # Without these it silently fails
        libXinerama
        libXcursor
        libXrender
        libXScrnSaver
        libXi
        libSM
        libICE
        gnome2.GConf
        nspr
        nss
        cups
        libcap
        SDL2
        libusb1
        dbus-glib
        ffmpeg
        # Only libraries are needed from those two
        libudev0-shim
        
        # Verified games requirements
        libXt
        libXmu
        libogg
        libvorbis
        SDL
        SDL2_image
        glew_1_10
        libidn
        tbb
        
        # Other things from runtime
        flac
        freeglut
        #libicu
        libjpeg
        libpng
        libpng12
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        SDL_image
        SDL_ttf
        SDL_mixer
        SDL2_ttf
        SDL2_mixer
        libappindicator-gtk2
        libdbusmenu-gtk2
        libindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        libXft
        libvdpau
        #gnome2.pango
        cairo
        atk
        gdk-pixbuf
        fontconfig
        freetype
        dbus
        alsa-lib
        expat
        # Needed for electron
        libdrm
  ];


  # Enable Swaylock for locking the screen
  #services.swaylock.enable = true;
  #services.swaylock.config = {
    #color = "#000000"; # Background color for lock screen
  #};

  #programs.hyprland.enable = "true";
  #programs.wofi.enable = true;



#--> NVIDIA LAPTOP

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  # "modesetting" "intel" # "nvidia"

  hardware.nvidia = {
     modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    open = false;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia-container-toolkit.enable = true;

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    # Make sure to use the correct Bus ID values for your system!
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
                # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
  };

  # Blacklist
  # "nvidia_drm" 
  boot = {
    blacklistedKernelModules = [ "nouveau" ]; # "i915"
    kernelParams =[ 
      "modprobe.blacklist=nouveau" 
      "nvidia-drm.fbdev=1" 
    ];
    
    #initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" ];
  };

  #boot.kernelPackages = pkgs.linuxKernel.packages.linux_latest;
  hardware.tuxedo-drivers.enable = true;
  #hardware.tuxedo-control-center.enable = true;

  #boot.kernelParams = [
    #"tuxedo_keyboard.mode=0"
    #"tuxedo_keyboard.brightness=255"
    # Opzionale: impostazioni colore per retroilluminazione
    # "tuxedo_keyboard.color_left=0xff0a0a"
  #];


#hardware.bumblebee.enable=true;
services.supergfxd.enable = true;

#hardware.nvidia.optimus = true;


              nixpkgs.config.permittedInsecurePackages = [
                #"mbedtls-2.28.10"
              ];

}
