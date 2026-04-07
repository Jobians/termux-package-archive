#!/usr/bin/env bash

APR_BUILD="$GITHUB_WORKSPACE/termux-packages/packages/apr/build.sh"

# Replace dlcdn.apache.org with archive.apache.org/dist in TERMUX_PKG_SRCURL
sed -i '/^TERMUX_PKG_SRCURL=/ s|dlcdn\.apache\.org|archive.apache.org/dist|' "$APR_BUILD"

# Display updated URL
grep "^TERMUX_PKG_SRCURL=" "$APR_BUILD"
