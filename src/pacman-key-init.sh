script=$0
cd /tmp \
  && pacman -Sy --noconfirm \
  && curl -O $(pacman -Swp haveged | head -1) \
  && pacman -U haveged-*.pkg.tar.* --noconfirm \
  && rm -f haveged-*.pkg.tar.* \
  && haveged -w 1024 \
  && pacman-key --init \
  && pacman -R haveged --noconfirm \
  && pacman-key --populate \
  && pacman -S archlinux-keyring --noconfirm \
  && rm $script
