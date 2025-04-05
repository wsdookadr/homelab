#!/bin/bash
for d in $(find /home/user/ -mindepth 1 -maxdepth 1 -type d); do
  if [[ ! -f "$d/docker-compose.yml" ]]; then
    continue
  fi
  if ! grep "restart:\s*always" $d/docker-compose.yml >/dev/null ; then
    continue
  fi
  sudo -u user bash -c "cd $d; docker compose up -d;"
done
