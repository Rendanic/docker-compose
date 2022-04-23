#!/usr/bin/bash
#
# (c) Thorsten Bruhns <thorsten.bruhns@googlemail.com>

workdir=$(dirname "$0")

"${workdir}/build.sh" 2.9
"${workdir}/build.sh" 2.10
"${workdir}/build.sh" 3
"${workdir}/build.sh" 4
