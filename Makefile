build: src/mirrorlist
	rm -f build.cid
	docker build -t retorillo/archlinux .
	docker run -itd --privileged --cidfile=build.cid retorillo/archlinux /bin/bash
	cid=$$(cat build.cid) && docker exec $$cid /bin/bash /tmp/pacman-key-init.sh \
		&& docker stop $$cid && docker commit $$cid retorillo/archlinux && docker rm $$cid && rm -f build.cid

tmp/archlinux-latest.tar.gz:
	wget -rl 1 -nc -nd --directory-prefix=tmp --accept=tar.gz,txt \
		--accept-regex='/(archlinux-bootstrap-[.0-9]+-x86_64\.tar\.gz|md5sums\.txt)$$' \
		http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/iso/latest/
	cd tmp &&	grep -E 'archlinux-bootstrap-[.0-9]+-x86_64\.tar\.gz$$' md5sums.txt | md5sum -c -
	mv tmp/archlinux-bootstrap*-x86_64.tar.gz tmp/archlinux-latest.tar.gz

src/archlinux.tar.xz:
	sudo rm -rf tmp/archlinux-latest && mkdir tmp/archlinux-latest
	sudo tar -xpf tmp/archlinux-latest.tar.gz --strip-component=1 -C tmp/archlinux-latest \
		--same-owner --atime-preserve --numeric-owner
	sudo tar -caf src/archlinux.tar.xz -C tmp/archlinux-latest --numeric-owner .

src/mirrorlist:
	curl "https://www.archlinux.org/mirrorlist/?country=all&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on" \
		| sed -e 's/^#//' > src/mirrorlist

tmp:
	mkdir tmp

clean:
	sudo rm tmp -rf
	rm src/mirrorlist -f

