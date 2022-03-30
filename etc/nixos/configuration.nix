# NixOS
# https://nixos.org/manual/nixos/stable/
# https://search.nixos.org/packages
# https://search.nixos.org/options

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
  system.stateVersion = "22.05";

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

  # Page: https://search.nixos.org/options

  networking.hostName = "kanto";
  # Generate the 32-bit host ID of the machine with:
  # head [--bytes -c] 8 /etc/machine-id
  networking.hostId = "0338c82e";
  # Note: ZFS requires networking.hostId to be set.
  networking.enableIPv6 = false;

  # Firewall
  # Allow incoming connections
  # https://nixos.org/manual/nixos/stable#sec-firewall
  # Hugo: 1313
  # receptor: 3000
  # Rails: 5000
  # GoTTY: 8080
  # The Lounge: 9000
  networking.firewall.allowedTCPPorts = [ 22 80 443 1313 3000 5000 8080 9000 ];

  time.timeZone = "Europe/Paris";

  # Location: Paris
  # https://google.com/search?q=Paris+Coordinates
  location.latitude = 48.8566;
  location.longitude = 2.3522;

  # Unfree
  # Allow VirtualBox, Discord…
  nixpkgs.config.allowUnfree = true;

  # Security
  # Do not prompt for password
  security.sudo.wheelNeedsPassword = false;

  # Automatic Upgrades
  # https://nixos.org/manual/nixos/stable#sec-upgrading-automatic
  system.autoUpgrade.enable = true;

  # Cleaning the Nix Store
  # https://nixos.org/manual/nixos/stable#sec-nix-gc
  nix.gc.automatic = true;

  # Clean temporary files during boot
  boot.cleanTmpDir = true;

  # Boot ───────────────────────────────────────────────────────────────────────

  # UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fix Linux slow CPU
  # https://discourse.nixos.org/t/browsers-unbearably-slow-after-update/9414
  boot.kernelParams = [ "intel_pstate=active" ];

  # Users ──────────────────────────────────────────────────────────────────────

  users.users.taupiqueur = {
    uid = 1000;
    # Indicates whether this is an account for a real user.
    # In other words, set a bunch of options for us.
    # https://search.nixos.org/options?query=isNormalUser
    isNormalUser = true;
    shell = pkgs.bash;
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
      "adbusers"
    ];
  };

  # Services ───────────────────────────────────────────────────────────────────

  # Optimize battery life
  # https://linrunner.de/tlp/
  services.tlp.enable = true;

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
  programs.ssh.startAgent = true;

  # Printing
  services.printing.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Fonts
  # https://nixos.wiki/wiki/Fonts
  fonts.fonts = with pkgs; [
    # terminus # http://terminus-font.sourceforge.net
    ubuntu_font_family # https://design.ubuntu.com/font/
    dejavu_fonts # https://dejavu-fonts.github.io
    font-awesome # https://fontawesome.com
  ];

  # Wayland compositors
  # Sway
  # https://swaywm.org
  programs.sway.enable = true;

  # Desktop environments
  # https://kde.org
  #
  # Note: KDE apps need `XDG_CURRENT_DESKTOP=kde` for non-KDE desktops.
  services.xserver.desktopManager.plasma5.enable = true;

  # Backlight
  programs.light.enable = true;

  # Android
  programs.adb.enable = true;

  # Virtualisation
  # virtualisation.lxc.enable = true;
  # virtualisation.lxd.enable = true;
  virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;
  # Install Oracle Extension Pack
  # Important: Requires nixpkgs.config.allowUnfree
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  # QEMU
  # https://qemu.org
  # services.qemuGuest.enable = true;

  # Parallels
  # https://parallels.com
  # hardware.parallels.enable = true;

  # PostgreSQL
  # https://postgresql.org
  # https://nixos.org/manual/nixos/stable#module-postgresql
  # services.postgresql.enable = true;
  # services.postgresql.package = pkgs.postgresql_13;
  # services.postgresql.dataDir = "/data/postgresql";

  # Packages ───────────────────────────────────────────────────────────────────

  # https://search.nixos.org/packages

  environment.systemPackages = with pkgs; [

    # Terminals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    alacritty # https://github.com/alacritty/alacritty
    konsole # https://konsole.kde.org
    foot # https://codeberg.org/dnkl/foot

    # Terminal multiplexers
    tmux # https://github.com/tmux/tmux
    tab-rs # https://github.com/austinjones/tab-rs

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

    dash # http://gondor.apana.org.au/~herbert/dash/
    bash # https://gnu.org/software/bash/

    # Shell prompts
    starship # https://starship.rs

    # Shell history
    mcfly # https://github.com/cantino/mcfly

    # Shell navigation
    zoxide # https://github.com/ajeetdsouza/zoxide

    # Text editors ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    kakoune # https://kakoune.org
    kak-lsp # https://github.com/kak-lsp/kak-lsp
    helix # https://helix-editor.com
    vscode # https://code.visualstudio.com
    neovim # https://neovim.io
    neovide # https://github.com/neovide/neovide
    emacs # https://gnu.org/software/emacs/

    # IDEs ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # IntelliJ IDEA
    # https://jetbrains.com/idea/
    jetbrains.idea-community
    jetbrains.jdk

    # Android Studio
    # https://developer.android.com/studio
    android-studio
    android-tools

    # File managers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    dolphin # https://apps.kde.org/en/dolphin
    broot # https://dystroy.org/broot/
    ranger # https://ranger.github.io
    vifm # https://vifm.info
    # sidetree
    # https://github.com/topisani/sidetree

    # Git ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    git # https://git-scm.com
    delta # https://github.com/dandavison/delta
    gitAndTools.gh # https://cli.github.com
    gitAndTools.gitui # https://github.com/extrawurst/gitui

    # Torrents ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    transmission # https://transmissionbt.com
    transmission-qt # https://transmissionbt.com

    # Web browsers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    google-chrome # https://google.com/chrome/

    # For testing
    chromium # https://chromium.org
    firefox # https://mozilla.org/firefox/
    opera # https://opera.com
    vivaldi # https://vivaldi.com
    brave # https://brave.com

    # Media players ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    mpv # https://mpv.io

    # Dependencies for mpv scripts
    translate-shell # https://www.soimort.org/translate-shell/

    # Utils
    ffmpeg_5 # FFmpeg https://ffmpeg.org
    yt-dlp # https://github.com/yt-dlp/yt-dlp

    # Music players ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    spotify # https://spotify.com

    # Videos editors ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    obs-studio # https://obsproject.com
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

    # Display managers
    sddm # https://github.com/sddm/sddm

    # Networking
    networkmanager # https://wiki.gnome.org/Projects/NetworkManager

    # Audio
    pavucontrol # https://freedesktop.org/software/pulseaudio/pavucontrol/

    # Backlight
    light # https://haikarainen.github.io/light/
    wlsunset # https://sr.ht/~kennylevinsen/wlsunset/

    # Wayland ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Wayland
    wayland # https://wayland.freedesktop.org
    xwayland # https://wayland.freedesktop.org/xserver.html

    # Sway
    sway # https://swaywm.org
    swaybg # https://github.com/swaywm/swaybg
    swayidle # https://github.com/swaywm/swayidle
    swaylock # https://github.com/swaywm/swaylock

    # river
    river # https://github.com/riverwm/river

    # Wayfire
    wayfire # https://wayfire.org

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

    tiny # https://github.com/osa1/tiny
    discord # https://discord.com
    slack # https://slack.com

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
    sameboy # Game Boy and Game Boy Color – https://sameboy.github.io
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

    # System information
    neofetch # https://github.com/dylanaraps/neofetch

    # Networking
    openssh # https://openssh.com
    openssl # https://openssl.org

    # Archivers
    archiver # https://github.com/mholt/archiver
    p7zip # https://7-zip.org

    # Programming languages
    jq # https://stedolan.github.io/jq/
    oq # https://github.com/Blacksmoke16/oq
    bc # https://en.wikipedia.org/wiki/Bc_(programming_language)

    # Utils ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    file # https://darwinsys.com/file/
    socat # http://www.dest-unreach.org/socat/

    # Filesystem
    parted # https://gnu.org/software/parted/
    gparted # https://gparted.org
    gptfdisk # https://rodsbooks.com/gdisk/

    # Watchers
    inotify-tools # https://github.com/inotify-tools/inotify-tools

    # XDG
    xdg_utils # https://freedesktop.org/wiki/Software/xdg-utils/ (provides xdg-open)

    # Notifications
    libnotify # https://developer.gnome.org/notification-spec/ (provides notify-send)

    # Spell checker
    aspell # http://aspell.net

    # Web ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Static site generators
    hugo # https://gohugo.io

    # Terminals
    ttyd # https://github.com/tsl0922/ttyd

    # Services
    ngrok # https://ngrok.com
    heroku # https://heroku.com

    # Servers
    nginx # https://nginx.org

    # Database
    sqlite # https://sqlite.org
    sqlitebrowser # https://sqlitebrowser.org
    redis # https://redis.io

    # Programming languages ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Bash
    nodePackages.bash-language-server # https://github.com/bash-lsp/bash-language-server

    # C
    gcc # https://gcc.gnu.org
    clang # https://clang.llvm.org
    llvm # https://llvm.org
    llvmPackages_rocm.llvm # provides llvm-config

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
    rust-analyzer # https://rust-analyzer.github.io

    # Crystal
    # https://crystal-lang.org
    crystal
    shards # https://github.com/crystal-lang/shards
    scry # https://github.com/crystal-lang-tools/scry

    # Ruby
    # https://ruby-lang.org
    ruby_3_0
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

    # Java
    # https://openjdk.java.net
    jdk
    gradle # https://gradle.org

    # Kotlin
    # https://kotlinlang.org
    kotlin
    # kotlin-language-server
    # https://github.com/fwcd/kotlin-language-server

    # Janet
    # https://janet-lang.org
    janet

  ];
}
