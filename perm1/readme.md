## Test connectivity

```
ansible -i inventory all -m ping
```

## Running Samba Remount Monitor for Docker containers upon power outage

```
ansible-playbook -i inventory p/samba-docker-monitor.yml

systemctl status samba-docker.timer
systemctl status samba-docker.service
```

Repoted times:

8min for NAS-using containers (example: jellyfin) to come back up after a power outage.

## Restart Docker containers that are supposed to be up

Basically some Docker compose stacks are supposed to be up and sometimes they're not.
This makes sure to bring them back up.

```
ansible-playbook -i inventory p/restart-docker.yml
```
