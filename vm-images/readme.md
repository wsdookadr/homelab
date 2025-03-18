# Goal

Setting up cloud images for all major Linux distros and for Windows.

## Running

```
ansible-playbook -i inventory main.yml --limit node1
```

## Notes

Getting the next free vmid:
```
pvesh get /cluster/nextid
```

Getting all names of all vms on the cluster:
```
pvesh get /cluster/resources  --output-format json | jq -c -r '.[] | select(.type="qemu") | .name' | sort
```

## Other

TODO: Make sure you fix the order of rootfs, /boot, /boot/efi such that rootfs is last and can be resized easily
and wouldn't require growing and shrinking all before it.
so order shown by lsblk should be /boot,/boot/efi,rootfs.

TODO: Avoid rebuilding images if they're already present.
