# NixOS
# https://nixos.org/nixos/manual/
# https://nixos.org/nixos/packages.html
# https://nixos.org/nixos/options.html

{ config, pkgs, ... }:
let
  # Pin a specific version
  # Could be a Git revision
  rev = "master";
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/${rev}.tar.gz";
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
  system.stateVersion = "20.09";

  # Flakes ─────────────────────────────────────────────────────────────────────

  # Flakes
  # https://nixos.wiki/wiki/Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # File systems ───────────────────────────────────────────────────────────────

  # boot.supportedFilesystems = [ "zfs" ];

  # Options ────────────────────────────────────────────────────────────────────

  # Page: https://nixos.org/nixos/options.html

  networking.hostName = "kanto";
  # Generate the 32-bit host ID of the machine with:
  # head [--bytes -c] 8 /etc/machine-id
  networking.hostId = "0338c82e";
  # Note: ZFS requires networking.hostId to be set.
  networking.enableIPv6 = false;

  # Firewall
  # Allow incoming connections
  # https://nixos.org/nixos/manual#sec-firewall
  # Hugo: 1313
  # receptor: 3000
  # Rails: 5000
  # GoTTY: 8080
  # The Lounge: 9000
  networking.firewall.allowedTCPPorts = [ 80 443 1313 3000 5000 8080 9000 ];

  # AdBlock via /etc/hosts
  # https://github.com/StevenBlack/hosts
  networking.extraHosts = builtins.readFile /home/taupiqueur/repositories/github.com/StevenBlack/hosts/hosts;

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

  users.extraUsers.taupiqueur = {
    uid = 1000;
    # Indicates whether this is an account for a real user.
    # In other words, set a bunch of options for us.
    # https://nixos.org/nixos/options.html#isNormalUser
    isNormalUser = true;
    shell = pkgs.nushell;
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
  # programs.waybar.enable = true;

  # X11
  services.xserver.enable = true;

  # Display manager
  services.xserver.displayManager.sddm.enable = true;

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
  # virtualisation.lxc.enable = true;
  # virtualisation.lxd.enable = true;
  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;
  # Install Oracle Extension Pack
  # Important: Requires nixpkgs.config.allowUnfree
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  # PostgreSQL
  # https://postgresql.org
  # https://nixos.org/nixos/manual#module-postgresql
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql_12;
  services.postgresql.dataDir = "/data/postgresql";

  # Packages ───────────────────────────────────────────────────────────────────

  # https://nixos.org/nixos/packages.html

  environment.systemPackages = with pkgs; [

    # Terminals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    alacritty # https://github.com/alacritty/alacritty

    # Terminal multiplexers
    # tab-rs
    # https://github.com/austinjones/tab-rs
    pueue # https://github.com/Nukesor/pueue

    # Fuzzy finders
    fzf # https://github.com/junegunn/fzf

    # Terminal tools
    tldr # man – https://tldr.sh
    glow # Markdown – https://github.com/charmbracelet/glow

    # Terminal utils
    exa # ls – https://the.exa.website
    fd # find – https://github.com/sharkdp/fd
    bat # cat – https://github.com/sharkdp/bat
    pastel # https://github.com/sharkdp/pastel
    ripgrep # grep – https://github.com/BurntSushi/ripgrep
    procs # ps – https://github.com/dalance/procs
    htop # top – https://htop.dev

    # Shells ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    nushell # https://nushell.sh
    dash # http://gondor.apana.org.au/~herbert/dash/

    # Shell prompts
    starship # https://starship.rs

    # Text editors ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    kakoune # https://kakoune.org
    kak-lsp # https://github.com/kak-lsp/kak-lsp

    # File managers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    dolphin # https://apps.kde.org/en/dolphin
    broot # https://dystroy.org/broot/

    # Git ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    git # https://git-scm.com
    gitAndTools.gh # https://cli.github.com
    gitAndTools.gitui # https://github.com/extrawurst/gitui

    # Email clients ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    aerc # https://aerc-mail.org

    # Torrents ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    synapse-bt # https://synapse-bt.org

    # IRC ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    thelounge # https://thelounge.chat

    # Web browsers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    chromium # https://chromium.org

    # For testing
    google-chrome # https://google.com/chrome/
    firefox # https://mozilla.org/firefox/
    opera # https://opera.com
    vivaldi # https://vivaldi.com
    brave # https://brave.com

    # Media players ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    mpv # https://mpv.io

    # Dependencies for mpv scripts
    translate-shell # https://www.soimort.org/translate-shell/

    # Utils
    ffmpeg-full # FFmpeg https://ffmpeg.org
    youtube-dl # https://yt-dl.org

    # Videos editors ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    olive-editor # https://olivevideoeditor.org

    # Image editors ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    inkscape # https://inkscape.org
    gimp # https://gimp.org

    # Document viewers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    zathura # https://pwmt.org/projects/zathura/

    # Document converters
    pandoc # https://pandoc.org
    tectonic # https://tectonic-typesetting.github.io
    img2pdf # https://gitlab.mister-muffin.de/josch/img2pdf

    # Desktop environments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    plasma-desktop # https://kde.org

    # Login managers
    sddm # https://github.com/sddm/sddm
    sddm-kcm # https://github.com/KDE/sddm-kcm

    # Networking
    networkmanager # https://wiki.gnome.org/Projects/NetworkManager

    # Audio
    pavucontrol # https://freedesktop.org/software/pulseaudio/pavucontrol/

    # Backlight
    light # https://haikarainen.github.io/light/
    redshift-wlr # http://jonls.dk/redshift/ (Wayland patch)

    # Fonts
    dejavu_fonts # https://dejavu-fonts.github.io
    font-awesome # https://fontawesome.com

    # Wayland ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Wayland
    wayland # https://wayland.freedesktop.org
    xwayland # https://wayland.freedesktop.org/xserver.html

    # Sway
    sway # https://swaywm.org
    swaybg # https://github.com/swaywm/swaybg
    swayidle # https://github.com/swaywm/swayidle
    swaylock # https://github.com/swaywm/swaylock

    # Status bars
    waybar # https://github.com/Alexays/Waybar

    # Services
    kanshi # Output configuration – https://wayland.emersion.fr/kanshi/
    mako # Notifications – https://wayland.emersion.fr/mako/

    # Clipboard
    wl-clipboard # https://github.com/bugaevc/wl-clipboard

    # Screenshots
    grim # https://wayland.emersion.fr/grim/
    slurp # https://wayland.emersion.fr/slurp/

    # Screencast
    wf-recorder # https://github.com/ammen99/wf-recorder

    # Utils
    wev # https://git.sr.ht/~sircmpwn/wev
    wlr-randr # https://github.com/emersion/wlr-randr

    # Messaging ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    discord # https://discord.com
    gitter # https://gitter.im

    # Games ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    steam # https://store.steampowered.com
    retroarch # https://retroarch.com

    # Game emulators
    # https://emulation.gametechwiki.com
    # mesen
    # NES – https://mesen.ca
    nestopia # NES – http://0ldsk00l.ca/nestopia/
    higan # SNES – https://higan.dev (formerly bsnes)
    mupen64plus # Nintendo 64 – https://mupen64plus.org
    # m64p
    # Mupen64Plus GUI – https://github.com/loganmc10/m64p
    # sameboy
    # Game Boy and Game Boy Color – https://sameboy.github.io
    mgba # GBA – https://mgba.io
    mednafen # PlayStation 1 – https://mednafen.github.io
    mednaffe # Mednafen GUI – https://github.com/AmatCoder/mednaffe
    pcsx2 # PlayStation 2 – https://pcsx2.net
    dolphinEmu # GameCube – https://dolphin-emu.org
    melonDS # Nintendo DS – http://melonds.kuribo64.net

    # Game utils
    xboxdrv # https://xboxdrv.gitlab.io
    ecmtools # https://github.com/alucryd/ecm-tools

    # Emulators ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    wine # https://winehq.org

    # Virtualization ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    docker # https://docker.com
    appimage-run # https://github.com/NixOS/nixpkgs/tree/master/pkgs/tools/package-management/appimage-run

    # Android ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    android-file-transfer # https://whoozle.github.io/android-file-transfer-linux/

    # iPod ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    gtkpod # http://gtkpod.org

    # Tools ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Archivers
    archiver # https://github.com/mholt/archiver

    # Programming languages
    jq # https://stedolan.github.io/jq/
    bc # https://en.wikipedia.org/wiki/Bc_(programming_language)

    # Utils ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    file # https://darwinsys.com/file/
    socat # http://www.dest-unreach.org/socat/

    # Filesystem
    gparted # https://gparted.org
    gptfdisk # https://rodsbooks.com/gdisk/

    # Watchers
    inotify-tools # https://github.com/inotify-tools/inotify-tools

    # XDG
    xdg_utils # https://freedesktop.org/wiki/Software/xdg-utils/ (provides xdg-open)

    # Notifications
    libnotify # https://developer.gnome.org/notification-spec/ (provides notify-send)

    # Web ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Static site generators
    hugo # https://gohugo.io

    # Services
    heroku # https://heroku.com

    # Servers
    nginx # https://nginx.org

    # Database
    sqlite # https://sqlite.org
    sqlitebrowser # https://sqlitebrowser.org
    redis # https://redis.io

    # Programming languages ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # C
    clang # https://clang.llvm.org
    llvm # https://llvm.org

    # Build systems
    gnumake # https://gnu.org/software/make/
    pkg-config # https://freedesktop.org/wiki/Software/pkg-config/
    meson # https://mesonbuild.com
    ninja # https://ninja-build.org

    # Rust
    # https://rust-lang.org
    rustc
    cargo # https://crates.io
    rustup # https://rustup.rs

    # Crystal
    # https://crystal-lang.org
    crystal
    shards # https://github.com/crystal-lang/shards
    scry # https://github.com/crystal-lang-tools/scry

    # Ruby
    # https://ruby-lang.org
    ruby_2_7
    solargraph # https://solargraph.org

    # Elixir
    # https://elixir-lang.org
    elixir

    # JavaScript
    nodejs_latest # https://nodejs.org
    yarn # https://yarnpkg.com
    flow # https://flow.org

    # OCaml
    # https://ocaml.org
    ocaml
    opam # https://opam.ocaml.org

    # Lua
    # https://lua.org
    lua5_4
    luarocks # https://luarocks.org

    # Python
    # https://python.org
    python39
    python39Packages.pip # https://pip.pypa.io

    # Go
    # https://golang.org
    go

    # Haskell
    # https://haskell.org
    ghc # https://haskell.org/ghc/
    cabal-install # https://hackage.haskell.org/package/cabal-install

    # Nim
    # https://nim-lang.org
    nim

    # Zig
    # https://ziglang.org
    zig

    # Common Lisp
    ccl # https://ccl.clozure.com
    sbcl # http://sbcl.org
    lispPackages.quicklisp # https://quicklisp.org

    # Clojure
    # https://clojure.org
    clojure # https://clojure.org
    leiningen # https://leiningen.org

    # Scala
    # https://scala-lang.org
    scala

    # Kotlin
    # https://kotlinlang.org
    kotlin

    # Janet
    # https://janet-lang.org
    janet

  ];
}
