;; Manifest for development env
(specifications->manifest
 '(
   ;; basic
   "emacs-pgtk-native-comp"
   ;;"git"
   "guix"
   "guile"
   "shepherd"
   "glibc-utf8-locales"
   ;;"tor"
   "python-searx"
   "python-vanguards"
   ;;"ungoogled-chromium-nvda"
   ;;"firefox-nvda"
   ;;"gnupg"
   ;;"transmission"
   ;;"steam-nvidia" ;; steam
   ;;"password-store"
   ;;"qemu"
   ;;"zfs"

   ;; C dev
   ;;"make" ;; "cmake"
   ;;"glibc" ;; "musl"
   ;;"gcc-toolchain" ;;"clang-toolchain"
   ;;"gdb" ;;"lldb"
   ;;"binutils"

   ;; java
   ;;"openjdk"
   ;;"maven"
   ;;"leiningen"
   ;;"clojure"

   ;; julia
   ;;"julia"

   ;; shell
   ;;"shellcheck"
   ;;"bash"
   ;;"htop"
   ;;"perf"
   ;;"xclip"
   ;;"bc"
   ;;"jq"
   ;;"coreutils" ;;"busybox"
   ;;"less"
   ;;"gzip"
   ;;"fdisk" ;;"gparted"
   ;;"wget"
   ;;"diffutils"
   ;;"findutils"
   ;;"tar"
   ;;"gawk"
   ;;"which"
   ;;"sed"
   ;;"grep"
   ;;"patch"
   ;;
   ;;"gash"
   ;;"gash-utils"

   ;; apps
   ;;"wine64"; "wine"
   ;;"winetricks"
   ;;"clamav"
   ;;"filezilla"
   ;;"lynx"
   ;;"libvirt"
   ;;"virt-manager"
   ;;"postgresql"
   ;;"sqlite"
   ;;"tigervnc-client"
   ;;"tigervnc-server"

   ;; docs
   ;;"libreoffice"
   ;;"calibre"
   ;;"biber"
   ;;"texlive"
   ;;"aspell-dict-en"

   ;; media
   ;;"blender"
   ;;"gimp"
   ;;"inkscape"
   ;;"vlc"
   ;;"mkvtoolnix"
   ;;"mediainfo"
   ;;"ffmpeg"
   ;;"gnuplot"
   ;;"makemkv"
   ;;"flamegraph"
   ;;"youtube-dl"

   ;; net
   ;;"curl"
   ;;"whois"
   ;;"bind:utils"
   ;;"nmap"
   ;;"python-onionbalance" ;;"python-stem"
   ;;"onionshare"
   ;;"iptables"
   ;;"ebtables"
   ;;"wireshark"
   ;;"netcat"
   ;;"net-tools"
   ;;"openssh" ;;"dropbear"
   ;;"wireguard-tools"
   ;;"torsocks"
   ;;"socat"

   ;; Desktop
   ;;"xfce"; --with-graft=mesa=nvda
   ;;"nvidia-driver"; add udev rules, mesa graft and xorg modules rules
   ))
