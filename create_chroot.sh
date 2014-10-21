#!/bin/sh

# References:
# https://sites.google.com/site/trevelyansmisc/tech-stuff/debian-32bit-chroot

main() {
	set -x

	install_deps

	SUITE=stable
	DISTRO=debian
	APT_REPO=
	ARCH=i386

	if [ "$1" = "lucid" ]; then
		SUITE=lucid
		APT_REPO=http://archive.ubuntu.com/ubuntu
		DISTRO=ubuntu

	elif [ "$1" = "oneiric" ]; then
		SUITE=oneiric
		APT_REPO=http://old-releases.ubuntu.com/ubuntu
		DISTRO=ubuntu
	fi

	echo ${SUITE} ${APT_REPO} ${DISTRO}

	CHROOT_DIR=/var/local/${DISTRO}-${SUITE}-32-ldap-auth
	sudo mkdir -p ${CHROOT_DIR}

	sudo debootstrap --foreign --arch=i386 ${SUITE} ${CHROOT_DIR} \
		${APT_REPO}
}


install_deps() {
	sudo apt-get install debootstrap
}


# Execute entry point.
main "$@"
