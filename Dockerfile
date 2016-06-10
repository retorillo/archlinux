FROM scratch
ADD /vanilla/root.x86_64 /
ADD /extra/mirrorlist /etc/pacman.d
ADD /extra/pacman-key-init.sh /tmp
ONBUILD RUN pacman -Syy
