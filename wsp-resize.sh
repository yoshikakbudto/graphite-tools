#!/bin/bash
#
#  find . -type f -regextype posix-extended -regex '(.*dev/.*)|(.*/dev3/.*)' > /tmp/wsp-dev.lst
#  then run this script with carbon user as so: su -mc './wsp-resize.sh' carbon
#

in=/tmp/wsp-dev.lst
aggrules="10s:1d 60s:7d 5m:14d"

log=${in}.log
wsproot=/var/lib/carbon/whisper/stats

pushd ${wsproot}

echo -e "\n*\n* $(date) Started \n*" >> ${log}
while read wsp; do
        /usr/bin/whisper-resize --nobackup ${wsp} ${aggrules} >> ${log}
done
