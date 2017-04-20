#!/bin/bash
MAINTAINER="john.lee@hardkernel.com"

PKGVER=`date +%Y%m%d`
GITREV=`git rev-parse --short HEAD`

checkinstall --pkgname="cloudshell-lcd" --pkgversion="$PKGVER" -A armhf --maintainer=\"$MAINTAINER\" --pkggroup="other" --pkglicense="GPLv2" --requires="curl,sysstat" --nodoc -y -d2 --pkgrelease="4" -D 
