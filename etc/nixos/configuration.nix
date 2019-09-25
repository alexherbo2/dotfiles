# NixOS
# https://nixos.org/nixos/manual/
# https://nixos.org/nixos/packages.html
# https://nixos.org/nixos/options.html

{ config, pkgs, ... }:

{
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
  # The Lounge: 9000
  networking.firewall.allowedTCPPorts = [ 80 443 9000 ];

  time.timeZone = "Europe/Paris";

  # Location: Paris
  # https://google.com/search?q=Paris+Coordinates
  location.latitude = 48.8566;
  location.longitude = 2.3522;

  # Unfree
  # Allow Discord, drivers for Wi-Fi…
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
      "networkmanager"
      "vboxusers"
      "wheel"
    ];
  };

  # Variables ──────────────────────────────────────────────────────────────────

  environment.variables = {
    EDITOR = "kak-connect";
    KAKOUNE_SESSION = "othala";
    XDG_CURRENT_DESKTOP = "kde";
  };

  # Browsers ───────────────────────────────────────────────────────────────────

  nixpkgs.config.chromium = {
    # enablePepperFlash = true;
    # enablePepperPDF = true;
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

  # X11
  services.xserver.enable = true;
  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # Display manager
  services.xserver.displayManager.sddm.enable = true;

  # Wayland compositors
  # Sway
  programs.sway.enable = true;

  # Window managers
  # i3
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
  # bspwm
  services.xserver.windowManager.bspwm.enable = true;

  # Desktop managers
  # Plasma
  services.xserver.desktopManager.plasma5.enable = true;

  # Qt
  # programs.qt5ct.enable = true;

  # Compositor for window managers
  services.compton.enable = true;

  # Backlight
  programs.light.enable = true;

  # Redshift
  services.redshift.enable = true;

  # Virtualisation
  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;

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
    asciidoc
    asciinema
    bash
    bat
    bc
    blender
    bspwm
    bundix
    cabal-install
    # cachix
    calibre
    cargo
    ccl
    chromium
    clang
    clojure
    cockatrice
    compton
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
    dtach
    dunst
    elvish
    emacs
    exa
    fd
    fdm
    ffmpeg-full
    file
    firefox
    flow
    font-awesome_5
    fzf
    gcc
    gdb
    ghc
    gimp
    git
    gitAndTools.diff-so-fancy
    git-lfs
    gnumake
    gnuplot
    go
    godot
    google-chrome
    gource
    gparted
    gptfdisk
    graphviz
    gsmartcontrol
    gtkpod
    heroku
    higan
    htop
    hugo
    hunspell
    hunspellDicts.en-us
    i3blocks
    i3-gaps
    imagemagick
    inkscape
    inotify-tools
    iproute
    iw
    jq
    kakoune
    kdeApplications.kdenlive
    kitty
    kotlin
    leiningen
    lemonbar-xft
    lf
    libnotify
    light
    lispPackages.quicklisp
    llvm
    lua
    luakit
    lxappearance-gtk3
    lxc
    lzip
    maim
    maven
    mgba
    mkvtoolnix
    mongodb
    mosh
    mpv
    msmtp
    mysql
    ncftp
    neovim
    neovim-qt
    nettools
    networkmanagerapplet
    nginx
    nim
    nix-index
    nmap
    nodejs-12_x
    notmuch
    ntfs3g
    ocaml
    opam
    openjdk12
    openssl
    opera
    p7zip
    # pandoc
    par
    pavucontrol
    pcre
    pcsx2
    pcsxr
    pdftk
    peek
    peruse
    plasma-desktop
    polybar
    postgresql
    python38
    python38Packages.pip
    qemu
    qutebrowser
    ranger
    redshift
    ripgrep
    rofi
    rtorrent
    ruby_2_6
    rustc
    rustup
    sbcl
    scala
    screenkey
    sddm
    setroot
    shards
    shellcheck
    skim
    smartmontools
    snes9x-gtk
    socat
    sox
    sqlite
    sshfs
    steam
    surf
    sway
    sxhkd
    tabbed
    tectonic
    tig
    tldr
    tmux
    tor
    translate-shell
    unrar
    unzip
    uzbl
    vanilla-dmz
    vim
    vimb
    vimHugeX
    virtualbox
    vis
    vivaldi
    vscode
    wayland
    weechat
    wget
    wine
    winetricks
    xboxdrv
    xclip
    xcompmgr
    xdo
    xdotool
    xorg.transset
    xorg.xbacklight
    xorg.xev
    xorg.xinit
    xorg.xkbcomp
    xorg.xmodmap
    xorg.xrdb
    yarn
    youtube-dl
    zathura
    zip
    zsnes
  ];

}
