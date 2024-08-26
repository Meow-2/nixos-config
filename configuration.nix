{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.kernelParams = [ "quiet" "loglevel=3" ];
  boot.loader =
    {
      efi.canTouchEfiVariables = true;
      grub =
        {
          default = "saved";
          device = "nodev";
          efiSupport = true;
          useOSProber = true;
          # gfxmodeEfi = "2560x1800";
          # fontSize = "16";
        };
    };

  users.users.zk = {
    isNormalUser = true;
    description = "zk";
    extraGroups = [ "networkmanager" "wheel" "input" "lp" "video" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPdeMYQVI3yYmadUlf9KMWZTgTYYeUfHTFtem2rEEPle admin@zk.com"
    ];
    # home = "/home/zk";
    # shell = "/bin/zsh";
  };

  networking.hostName = "HpZBook"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  nix.settings = {
    #   trusted-users = [ "zk" ];
    #   # enable flakes globally
    experimental-features = [ "nix-command" "flakes" ];
    #
    substituters = [
      #     # cache mirror located in China
      #     # status: https://mirror.sjtu.edu.cn/
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      #     # status: https://mirrors.ustc.edu.cn/status/
      #     # "https://mirrors.ustc.edu.cn/nix-channels/store"
      #
      #     "https://cache.nixos.org"
    ];
    #
    #   trusted-public-keys = [
    #     "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    #   ];
    # builders-use-substitutes = true;
  };
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  # hardware.graphics.extraPackages = with pkgs; [
  #   intel-compute-runtime
  #   intel-media-driver
  # ];
  #
  # hardware.graphics.enable32Bit = true;

  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;


  services.xserver.xkb.layout = "us";
  services.xserver.autoRepeatDelay = 210;
  services.xserver.autoRepeatInterval = 40;
  services.xserver.xkb.options = "caps:swapescape,ctrl:ralt_rctrl";

  services.libinput.enable = true;
  services.libinput.touchpad.accelSpeed = "0.4";
  services.libinput.touchpad.disableWhileTyping = true;
  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.touchpad.tapping = true;

  # qt.enable = true;
  # qt.platformTheme = "gtk2";
  # qt.style = "gtk2";

  nixpkgs.config = {
    allowUnfree = true;
  };

  # picom-ftlabs-git 等待打包
  # dwm 等待打包
  # bluetooth-autoconnect 等待打包
  # utools 等待打包
  # snipaste 等待打包
  # diodon 等待打包
  # vscode-codicons 等待打包
  # Misans 等待打包

  environment.systemPackages = with pkgs; [
    git
    wget
    curl

    zsh # shell
    xclip
    zimfw
    fastfetch
    man
    nettools
    fastfetch
    pv
    ripgrep
    trash-cli
    fzf
    fd
    sshfs
    lf
    bat
    lolcat
    tig

    neovim
    # python-neovim
    lua
    lazygit
    nodejs_18

    # dwm
    (callPackage ./modules/dwm/default.nix { })

    # top
    light
    xdg-utils
    libinput-gestures
    playerctl
    safeeyes
    alsa-utils # aplay for safeeyes
    acpi
    xprintidle # lock with screen on
    btop # or bottom 
    mpv
    redshift
    feh
    xwinwrap # mvp as paper
    dunst
    xss-lock
    # openssl_1_1 # for wps and utools
    libsForQt5.fcitx5-with-addons
    libsForQt5.fcitx5-chinese-addons
    fcitx5-rime
    fcitx5-material-color
    peazip
    gnome.nautilus # 依赖gvfs
    gnome.gnome-keyring
    microsoft-edge-dev
    kitty
    lxrandr # 屏幕管理
    v2raya
    xray
    v2ray-domain-list-community
    ripgrep

    gnome.gdm
    polkit
    polkit_gnome
    libsForQt5.polkit-qt


    nwg-look
    fluent-gtk-theme
    fluent-icon-theme
    papirus-icon-theme

    networkmanager
    networkmanagerapplet # gui
    bluez
    blueman # gui
    pulseaudio
    pavucontrol # gui

    # plank
    # listen1
    # dbeaver-bin
    # jetbrains.idea-ultimate
    # jetbrains.webstorm
    # vscode
    # qq
    # wechat-uos
    # dropbox
    # obsidian
    # wpsoffice-cn
    # vmware-workstation
    # obs-studio
    # steam
  ];

  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
    hackgen-nf-font
  ];

  programs.steam.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
