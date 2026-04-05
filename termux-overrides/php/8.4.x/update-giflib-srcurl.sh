#!/usr/bin/env bash

GIFLIB_BUILD="$GITHUB_WORKSPACE/termux-packages/packages/giflib/build.sh"

# Insert "5.x/" after "giflib-" in TERMUX_PKG_SRCURL
sed -i '/^TERMUX_PKG_SRCURL=/ s|giflib-|giflib-5.x/|' "$GIFLIB_BUILD"

# Display updated URL
grep "^TERMUX_PKG_SRCURL=" "$GIFLIB_BUILD"
