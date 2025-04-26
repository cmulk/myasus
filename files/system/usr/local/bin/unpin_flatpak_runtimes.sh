#!/usr/bin/env bash

# fail on error
set -euo pipefail

# Get a list of all pinned flatpak runtimes
pinned_runtimes=$(flatpak pin | awk '{print $1}')

# Loop through the pinned runtimes and unpin them
for runtime in $pinned_runtimes; do
    flatpak pin --remove "$runtime"
    echo "Unpinned $runtime"
done
