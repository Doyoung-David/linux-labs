#!/bin/bash

#1. Resize partition 3 to use full disk
sudo parted /dev/nvme0n1 resizepart 3 100%

#2. Update kernel with new partition table
sudo partprobe /dev/nvme0n1

#3. Resize LVM physical volume
sudo pvresize /dev/nvme0n1p3

#4. Extend root LV along with filesystem
sudo lvextend -r -l +100%FREE /dev/rl/root

#5. Verify current root filesystem size
df -h /
lsblk
