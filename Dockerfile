FROM scratch
MAINTAINER Retorillo <retorillo@outlook.com>
ADD src/archlinux.tar.xz /
ADD src/mirrorlist /etc/pacman.d
ADD src/pacman-key-init.sh /tmp
