# NixOS
# https://nixos.org/nixos/manual/
# https://nixos.org/nixos/packages.html
# https://nixos.org/nixos/options.html

{ config, pkgs, ... }:
let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
in
{
  nixpkgs.overlays = [ waylandOverlay ];
  imports = [
    # Include the results of the hardware scan,
    # generated by nixos-generate-config.
    ./hardware-configuration.nix
  ];

  # This value determines the NixOS release with which your system is to be compatible,
  # in order to avoid breaking some software such as database servers.
  # You should change this only after NixOS release notes say you should.
  system.stateVersion = "18.03";

  # File systems ───────────────────────────────────────────────────────────────

  boot.supportedFilesystems = [ "zfs" ];

  # Options ────────────────────────────────────────────────────────────────────

  # Page: https://nixos.org/nixos/options.html

  networking.hostName = "othala";
  # Generate the 32-bit host ID of the machine with:
  # head [--bytes -c] 8 /etc/machine-id
  networking.hostId = "0338c82e";
  # Note: ZFS requires networking.hostId to be set.
  networking.enableIPv6 = false;

  # Firewall
  # Allow incoming connections
  # https://nixos.org/nixos/manual#sec-firewall
  # receptor: 3000
  # GoTTY: 8080
  # The Lounge: 9000
  networking.firewall.allowedTCPPorts = [ 80 443 3000 8080 9000 ];

  # AdBlock via /etc/hosts
  # https://github.com/StevenBlack/hosts
  networking.extraHosts = builtins.readFile /home/alex/repositories/github.com/StevenBlack/hosts/hosts;

  time.timeZone = "Europe/Paris";

  # Location: Paris
  # https://google.com/search?q=Paris+Coordinates
  location.latitude = 48.8566;
  location.longitude = 2.3522;

  # Unfree
  # Allow VirtualBox, Discord, drivers for Wi-Fi…
  nixpkgs.config.allowUnfree = true;

  # Security
  # Do not prompt for password
  security.sudo.wheelNeedsPassword = false;

  # Optimization – Speed-up builds
  # Jobs to run in parallel
  nix.maxJobs = 1;
  # Use all available cores when set to 0
  nix.buildCores = 1;

  # Lower the Nix daemon process priority
  # nix.daemonNiceLevel = 19;
  # nix.daemonIONiceLevel = 7;

  # CPU throttling
  # systemd.enableCgroupAccounting = true;
  # systemd.services.nix-daemon.serviceConfig.CPUQuota = "10%";

  # Automatic Upgrades
  # https://nixos.org/nixos/manual#idm140737316591792
  # system.autoUpgrade.enable = true;

  # Cleaning the Nix Store
  # https://nixos.org/nixos/manual#sec-nix-gc
  nix.gc.automatic = true;

  # Clean temporary files during boot
  boot.cleanTmpDir = true;

  # Boot ───────────────────────────────────────────────────────────────────────

  # UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [
    # Wi-Fi (Unfree)
    "wl"
  ];

  boot.extraModulePackages = [
    # Wi-Fi (Unfree)
    config.boot.kernelPackages.broadcom_sta
  ];

  # Users ──────────────────────────────────────────────────────────────────────

  users.extraUsers.alex = {
    uid = 1000;
    # Indicates whether this is an account for a real user.
    # In other words, set a bunch of options for us.
    # https://nixos.org/nixos/options.html#isNormalUser
    isNormalUser = true;
    extraGroups = [
      "audio"
      "disk"
      "docker"
      "games"
      "lxd"
      "networkmanager"
      "sway"
      "vboxusers"
      "video"
      "wheel"
    ];
  };

  # Environment variables ──────────────────────────────────────────────────────

  environment.variables = {
    EDITOR = "kak";
  };

  # Services ───────────────────────────────────────────────────────────────────

  # Login
  services.logind.lidSwitch = "ignore";
  services.logind.extraConfig = ''
    HandlePowerKey=hibernate
    HandleSuspendKey=suspend
    HandleHibernateKey=hibernate
  '';

  # Networking
  networking.networkmanager.enable = true;

  # SSH
  services.openssh.enable = true;

  # Printing
  services.printing.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Wayland compositors
  # Sway
  programs.sway.enable = true;

  # Waybar
  programs.waybar.enable = true;

  # X11
  services.xserver.enable = true;

  # Display manager
  services.xserver.displayManager.sddm.enable = true;

  # Window managers
  # i3
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  # Desktop managers
  # Plasma
  # Note: Required for icons
  services.xserver.desktopManager.plasma5.enable = true;

  # Backlight
  programs.light.enable = true;

  # Redshift
  services.redshift.enable = true;
  services.redshift.package = pkgs.redshift-wlr;

  # Virtualisation
  virtualisation.lxc.enable = true;
  virtualisation.lxd.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  # Install Oracle Extension Pack
  # Important: Requires nixpkgs.config.allowUnfree
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Packages ───────────────────────────────────────────────────────────────────

  # Page: https://nixos.org/nixos/packages.html
  # To search, run:
  # $ nix search {query}
  environment.systemPackages = with pkgs; [
    acpi
    aegisub
    aircrack-ng
    alacritty
    albert
    android-file-transfer
    apacheHttpd
    appimagekit
    appimage-run
    archiver
    asciidoc
    asciinema
    bash
    bat
    bc
    blender
    brave
    broot
    bspwc
    bundix
    cabal-install
    # cachix
    cage
    calibre
    cargo
    ccl
    celluloid
    chromium
    clang
    clojure
    cockatrice
    cquery
    crystal
    ctags
    curl
    dash
    dejavu_fonts
    desmume
    discord
    dmenu
    docker
    dolphin
    dolphinEmu
    dunst
    ecmtools
    elvish
    emacs
    exa
    fd
    fdm
    feh
    ffmpeg-full
    figlet
    file
    firefox
    flow
    font-awesome_5
    fuse
    fzf
    gcc
    gdb
    ghc
    gimp
    git
    gitAndTools.diff-so-fancy
    git-lfs
    glow
    gnumake
    go
    google-chrome
    gotty
    gource
    gparted
    gptfdisk
    graphviz
    grim
    gsmartcontrol
    gtkpod
    guile
    heroku
    higan
    htop
    hugo
    hunspell
    hunspellDicts.en-us
    i3
    inkscape
    inotify-tools
    iw
    janet
    jq
    kak-lsp
    kakoune
    kanshi
    kdeApplications.kdenlive
    kitty
    kotlin
    leiningen
    lf
    libnotify
    light
    lispPackages.quicklisp
    llvm
    lua
    luarocks
    lxc
    lxd
    lzip
    mako
    maven
    mediainfo
    mednafen
    mednaffe
    meson
    mgba
    mkvtoolnix
    mongodb
    mosh
    mpv
    msmtp
    mysql
    # neovim
    # neovim-qt
    nettools
    networkmanager
    next
    nginx
    nim
    ninja
    nix-index
    nmap
    nodejs-13_x
    notmuch
    ntfs3g
    nushell
    obs-wlrobs
    ocaml
    opam
    openjdk12
    openssl
    opera
    p7zip
    pandoc
    par
    pastel
    pavucontrol
    pcre
    # pcsx2
    pcsxr
    pdftk
    plan9port
    plasma-desktop
    polybar
    postgresql
    python38
    python38Packages.pip
    qemu
    qutebrowser
    redshift
    retroarch
    ripgrep
    ruby_2_7
    rustc
    rustup
    sbcl
    scala
    shards
    shellcheck
    skim
    slurp
    smartmontools
    snes9x-gtk
    socat
    solargraph
    sox
    sqlite
    sshfs
    st
    steam
    surf
    sway
    swaybg
    swayidle
    swaylock
    synapse-bt
    tectonic
    tig
    tigervnc
    tilix
    tldr
    tmux
    tor
    translate-shell
    unrar
    unzip
    vanilla-dmz
    vim
    vimHugeX
    # Remove VirtualBox from systemPackages to start VMs as a user.
    # virtualbox
    vivaldi
    vscode
    waybar
    waybox
    wayfire
    wayland
    wev
    wf-recorder
    wget
    (wine.override { wineBuild = "wine64"; })
    winetricks
    wl-clipboard
    wlogout
    wlr-randr
    wofi
    xboxdrv
    xcompmgr
    xdg_utils
    xorg.xev
    xorg.xinit
    xorg.xkbcomp
    xorg.xmodmap
    xwayland
    yarn
    youtube-dl
    zathura
    zip
    zsnes
  ];

}
