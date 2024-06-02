#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: ${0} <SSH host of radxa>"
fi

cdir="$(dirname "$(readlink -f "${0}")")"

"${cdir}"/build.sh

echo "sending firmware to ${1}"
scp "${cdir}"/build/src/box_rp2040.elf "${1}":/tmp/
scp "${cdir}"/../tools/flash_rp2040_firmware.sh "${1}":/tmp
ssh "${1}" '/tmp/flash_rp2040_firmware.sh /tmp/box_rp2040.elf'
