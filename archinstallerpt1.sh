cfdisk && mkfs.ext4 /dev/vda1 && mkswap /dev/vda2 && mount /dev/vda1 /mnt && swapon /dev/vda2 && pacstrap -K /mnt base linux linux-firmware && genfstab -U /mnt >> /mnt/etc/fstab && arch-chroot /mnt
