#makes the partions
cfdisk
mkfs.ext4 /dev/vda1
mkswap /dev/vda2
mount /dev/vda1 /mnt
swapon /dev/vda2
#sets up the chroot
pacstrap -K /mnt base linux linux-firmware
#makes the fstab
genfstab -U /mnt >> /mnt/etc/fstab
#chroots the system
arch-chroot /mnt
#sets the time
ln -sf /usr/share/zoneinfo/australia/perth
hwclock --systohc
#installs vim
pacman -S vim
#generates the locale
vim /etc/locale.gen
vim /etc/locale.conf
locale-gen
#adds your hostname
echo "#this is the hostname file" > /etc/hostname
#generates the initramfs
mkinitcpio -P
#adds the user
useradd -m schneiderman
passwd schneiderman
usermod -aG wheel,video,audio,optical,storage
#installs some packages
pacman -S sudo grub networkmanager
#sets up sudo
EDITOR=vim visudo
#sets up networkmanager
systemctl enable NetworkManager
#installs grub
grub-install /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg
#exits the chroot, reboots and unmounts the system
exit
umount -R /mnt
reboot
