#!/bin/bash

mkdir -p /pg_data /pg_wal

DISK1=$(lsblk -dno NAME,SIZE,MOUNTPOINT | awk -v size="5G" '$2==size && $3=="" {print "/dev/"$1}')
if ! blkid "$DISK1" >/dev/null 2>&1; then mkfs.ext4 -F "$DISK1"; fi
UUID_D1=$(blkid -s UUID -o value "${DISK1}")
grep -q "$UUID_D1" /etc/fstab || echo "UUID=$UUID_D1 /pg_data ext4 defaults 0 2" >> /etc/fstab

DISK2=$(lsblk -dno NAME,SIZE,MOUNTPOINT | awk -v size="2G" '$2==size && $3=="" {print "/dev/"$1}')
if ! blkid "$DISK2" >/dev/null 2>&1; then mkfs.ext4 -F "$DISK2"; fi
UUID_D2=$(blkid -s UUID -o value "${DISK2}")
grep -q "$UUID_D2" /etc/fstab || echo "UUID=$UUID_D2 /pg_wal ext4 defaults 0 2" >> /etc/fstab

mount -a
