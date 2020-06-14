;; Manifest for development env
(specifications->manifest
 '(
   ;; basic
   "emacs-pgtk-native-comp" ;; nativecomp merged in 28
   "git"
   "guix"
   "guile"
   ;;"gnupg"
   ;;"zfs"

   ;; C dev
   ;;"make" ;; "cmake"
   ;;"glibc" ;; "musl"
   ;;"glibc-utf8-locales"
   ;;"gcc" ;;"clang"
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
   ;;"transmission"
   ;;"qemu"
   ;;"libvirt"
   ;;"virt-manager"
   ;;"postgresql"
   ;;"sqlite"
   ;;"tigervnc-client"
   ;;"tigervnc-server"
   ;;"steam"
   ;;"steam-nvidia"

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
   ;;"tor"
   ;;"torsocks"
   ;;"python-stem"
   ;;"onionshare"
   ;;"ungoogled-chromium"; --with-graft=mesa=nvda
   ;;"iptables"
   ;;"ebtables"
   ;;"wireshark"
   ;;"netcat"
   ;;"net-tools"
   ;;"openssh" ;;"dropbear"
   ;;"wireguard-tools"

   ;; Desktop
   ;;"xfce"; --with-graft=mesa=nvda
   ;;"nvidia-driver"; add udev rules, mesa graft and xorg modules rules
   ))
