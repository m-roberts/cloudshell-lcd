#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT="$(dirname "$DIR")"

# Setup
apt install -y devscripts equivs libfile-fcntllock-perl
mk-build-deps --install "$PARENT"/debian/control

# Install
# -     From root of the package
cd "$PARENT"
dpkg-buildpackage