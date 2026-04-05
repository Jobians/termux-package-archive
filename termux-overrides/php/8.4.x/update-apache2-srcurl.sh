#!/usr/bin/env bash

APACHE2_BUILD="$GITHUB_WORKSPACE/termux-packages/packages/apache2/build.sh"

# Replace downloads.apache.org with archive.apache.org/dist in TERMUX_PKG_SRCURL
sed -i '/^TERMUX_PKG_SRCURL=/ s|downloads.apache.org|archive.apache.org/dist|' "$APACHE2_BUILD"

# Display updated URL
grep "^TERMUX_PKG_SRCURL=" "$APACHE2_BUILD"
