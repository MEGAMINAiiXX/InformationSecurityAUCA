#!/usr/bin/env bash
set -euo pipefail

package=${1:-nginx}

printf 'APT policy for %s:\n' "$package"
apt-cache policy "$package"
printf '\nPackage metadata:\n'
apt show "$package"
printf '\nDependencies:\n'
apt-cache depends "$package"

if dpkg-query -W -f='${Status}\n' "$package" 2>/dev/null | grep -q 'install ok installed'; then
    printf '\nInstalled package:\n'
    dpkg-query -W -f='${Package} ${Version} ${Status}\n' "$package"
else
    printf '\n%s is not installed.\n' "$package"
fi
