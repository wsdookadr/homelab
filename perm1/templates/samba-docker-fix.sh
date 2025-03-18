#!/bin/bash
IP="192.168.1.100"
SHARE="/shared-space"
A=$(cat /proc/mounts | grep /home/nas/shared | wc -l)
B=$(timeout 13 ls /home/nas/shared/ >/dev/null 2>/dev/null ; echo $?)
C=$(timeout 13 smbclient //$IP$SHARE -U guest% -c 'dir' >/dev/null 2>/dev/null; echo $?)
A=$(( !$A ))
C=$(( !$C ))

DC=()
DC+=(/home/user/jellyfin)
#DC+=(/home/user/gitea)
DC+=(/home/user/audiobooks)
#DC+=(/home/user/homebox)
#DC+=(/home/user/vaultwarden)
DC+=(/home/user/recoll-web-docker)
DC+=(/home/user/transmission)
#DC+=(/home/user/irc)
#DC+=(/home/user/femtocrawl)
#DC+=(/home/user/dns)
DC+=(/home/user/bookshelf)
DC+=(/home/user/filebrowser)
#DC+=(/home/user/community.general)
#DC+=(/home/user/wsdookadr.github.io)
#DC+=(/home/user/monitoring)
DC+=(/home/user/navidrome)
#DC+=(/home/user/teable)
#DC+=(/home/user/dokuwiki)
DC+=(/home/user/metube)
#DC+=(/home/user/stirling-pdf)
DC+=(/home/user/inkheart)
DC+=(/home/user/tubesync)
#DC+=(/home/user/jupyter)
#DC+=(/home/user/paperless-ngx)

## Logging
# echo $(date +"%Y-%m-%d %H:%M:%S")" A=$A B=$B C=$C" >> /home/user/.samba.docker.log

# if Samba server is available
if [[ "$C" -eq "1" ]]; then
  # is Samba share unmounted or unresponsive
  if [ "$A" -ne "0" ] || [ "$B" -ne "0" ]; then
    for s in "${DC[@]}"; do
      sudo -u user bash -c "cd $s; docker compose stop;"
    done
    umount -A --recursive /home/nas/
    mount -a
    sleep 1
    ls /home/nas/videos
    for s in "${DC[@]}"; do
      sudo -u user bash -c "cd $s; docker compose up -d;"
    done
  fi
else
  umount -A --recursive /home/nas/
  for s in "${DC[@]}"; do
    sudo -u user bash -c "cd $s; docker compose stop;"
  done
fi


