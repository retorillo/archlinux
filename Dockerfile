FROM scratch
ADD src/archlinux.tar.xz /
ADD src/mirrorlist /etc/pacman.d
ADD src/pacman-key-init.sh /tmp
