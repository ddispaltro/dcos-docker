#!/bin/bash
set -e
set +x

update(){
	apt-get -y update
	apt-get -y upgrade
	apt-get -y autoremove
	apt-get -y autoclean
	apt-get -y clean
}

update_kernel(){
	update

	stretch_sources=/etc/apt/sources.list.d/stretch.list

	echo "deb http://httpredir.debian.org/debian stretch main contrib non-free" > $stretch_sources

	apt-get update
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
		-o Dpkg::Options::="--force-confdef" \
		-o Dpkg::Options::="--force-confold" \
		-t stretch \
		linux-image-amd64 \
		linux-headers-amd64

	rm $stretch_sources
	update
}

update_kernel
sudo reboot
sleep 60
