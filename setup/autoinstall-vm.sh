
sfdisk /dev/sda <<FDISK
label: gpt
label-id: E8A5D08E-B8D2-4F42-80CE-79D072309035
device: /dev/sda
unit: sectors
first-lba: 2048
last-lba: 20971486
sector-size: 512

/dev/sda1 : start=       2048, size=    2097152, type= C12A7328-F81F-11D2-BA4B-00A0C93EC93B, uuid= AC06E570-7D7D-48E4-9CBC-39C441FF1B53
/dev/sda2 : start=    2099200, size=   18870272, type= 0FC63DAF-8483-4772-8E79-3D69D8477DE4, uuid= 3682670A-FBD8-4B80-9282-5B61A12D78FA
FDISK

mkfs.fat -F 32 /dev/sda2
mkfs.ext4 /dev/sda1

mount /dev/sda2 /mnt
mount --mkdir /dev/sda1 /mnt/boot

reflector --sort rate --latest 20 --save /etc/pacman/mirrorlist
pacstrap -K /mnt base linux linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab
echo "ssh /root/.ssh vboxsf uid=0,gid=vboxsf,ro 0 0" >> /mnt/etc/fstab
echo "config /root/configs vboxsf uid=0,gid=root,ro 0 0" >> /mnt/etc/fstab

arch-chroot /mnt <<GUEST
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

sed -i "/^#\(en_US\|fr_FR\)\.UTF-8/ s/^#//" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
#echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
echo "Arch-VM-njaber" > /etc/hostname

systemctl enable systemd-networkd systemd-resolved
echo "nameserver 8.8.8.8" >> /etc/resolve.conf

mkinitcpio -P

useradd -r config
useradd -m njaber
chpasswd <<PASSWD
root:vmjaber
config:vmjaber
njaber:vmjaber
PASSWD
passwd -e root
passwd -e njaber
sed -i '/^root/ a "config ALL=(ALL:ALL) ALL"'

pacman -S grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S virtualbox-guest-utils

systemctl enable vboxservice
GUEST

cat > /mnt/etc/systemd/network/10-vmlink.network <<NET
[Match]
Name=enp*

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes
NET

umount -R /mnt
