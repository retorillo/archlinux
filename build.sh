if [ ! -e vanilla ]; then
  mkdir vanilla
  chmod 755 vanilla
  cd vanilla
  wget http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/iso/2016.06.01/archlinux-bootstrap-2016.06.01-x86_64.tar.gz
  wget http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/iso/2016.06.01/md5sums.txt
  cd -
fi

if [ -e build.cid ]; then
  rm build.cid
fi

cd vanilla \
&& grep x86_64\.tar\.gz$ md5sums.txt | md5sum -c \
&& sudo rm root.x86_64/ -rf \
&& tar -xf archlinux-bootstrap-2016.06.01-x86_64.tar.gz root.x86_64/ \
&& cd - \
&& docker build -t retorillo/archlinux . \
&& docker run -it --privileged --cidfile=build.cid retorillo/archlinux bash /tmp/pacman-key-init.sh \
&& buildcid=`cat build.cid` \
&& docker commit $buildcid retorillo/archlinux

