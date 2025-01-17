
set -e

if ! ([ -e /dev/vda1 ] && [ -e /dev/vda2 ]); then

sfdisk /dev/vda <<FDISK
label: gpt
label-id: E2B8DFBA-0E15-4A10-B322-3914BC5011EB
device: /dev/vda
unit: sectors
first-lba: 2048
last-lba: 20971486
sector-size: 512

/dev/vda1 : start=        2048, size=     2097152, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, uuid=72B6AE3E-9A8D-4524-B70A-2C1C7CB76B36
/dev/vda2 : start=     2099200, size=    18870272, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, uuid=B1A1998E-60E1-4F37-8010-7967260E05AB
FDISK

mkfs.fat -F 32 /dev/vda1
mkfs.ext4 /dev/vda2
fi

mount /dev/vda2 /mnt
mount --mkdir /dev/vda1 /mnt/boot

[ -z "$(find /etc/pacman.d/mirrorlist -cmin 600)" ] || reflector --sort rate --latest 20 --save /etc/pacman.d/mirrorlist
[ -e /mnt/boot/vmlinuz-linux ] || pacstrap -K /mnt base linux linux-firmware

genfstab -U /mnt > /mnt/etc/fstab
echo "ssh /host/ssh 9p trans=virtio,version=9p2000.L,rw,uid=njaber,gid=njaber 0 0" >> /mnt/etc/fstab
echo "configs /host/configs 9p trans=virtio,version=9p2000.L,rw,uid=root,gid=njaber 0 0" >> /mnt/etc/fstab
echo "/host/ssh /root/.ssh none bind,defaults 0 0" >> /mnt/etc/fstab
echo "/host/ssh /home/njaber/.ssh none bind,defaults 0 0" >> /mnt/etc/fstab
echo "/host/configs /home/njaber/configs none bind,defaults 0 0" >> /mnt/etc/fstab

arch-chroot /mnt <<GUEST
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

sed -i "/^#\(en_US\|fr_FR\)\.UTF-8/ s/^#//" /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
#echo "KEYMAP=fr-latin1" > /etc/vconsole.conf
echo "Arch-VM-njaber" > /etc/hostname

systemctl enable systemd-networkd systemd-resolved

useradd -r config
useradd -m njaber -u $(stat -c '%u' /host/configs)
groupmod -g njaber -u $(stat -c '%g' /host/configs)
chpasswd <<PASSWD
root:vmjaber
config:vmjaber
njaber:vmjaber
PASSWD
passwd -e root
passwd -e njaber

pacman --needed -S --noconfirm grub efibootmgr < /dev/null

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman --needed -S --noconfirm spice-vdagent < /dev/null
systemctl enable spice-vdagentd

pacman --needed -S --noconfirm sudo < /dev/null

mkinitcpio -P

GUEST

mkdir -p /etc/sudoers.d
cat | tee /etc/sudoers.d/10-defaults <<SUDOERS
Defaults timestamp_type = kernel
Defaults tty_tickets = false
config ALL=(ALL:ALL) ALL
njaber ALL= (ALL:ALL) NOPASSWD: ALL
SUDOERS


cat | tee /mnt/etc/systemd/network/10-vmlink.network <<NET
[Match]
Name=enp*

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes
NET

umount -R /mnt
echo "Unmounted!"
