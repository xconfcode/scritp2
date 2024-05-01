#!/usr/bin/env bash
pacman -Syy archlinux-keyring
# ==========================================================================
#               [Start:: generate lang && Time]
# ==========================================================================

# Time

echo " Setting Times"
ln -sf /usr/share/zoneinfo/America/New_York   /etc/localtime
echo "Successfly configure Times"


sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^#en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen

locale-gen
hwclock --systohc
export LANG=en_US.UTF-8
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# ==========================================================================
#               [end:: generate lang]
# ==========================================================================






# ==========================================================================
#               [Start :: credentials]
# ==========================================================================
# Get user credentials
echo " Enter username then password"
read -r -p "Username: " USER
read -s -p "Password: " PASSWORD
echo -e "\nEnter root password"
passwd

echo

# ==========================================================================
#               [END:: credentials]
# ==========================================================================

# ==========================================================================
#               [Start ::  Configure Accounts]
# ==========================================================================
echo " start creating user"
useradd -m -s /bin/bash "$USER"
echo "$USER:$PASSWORD" | chpasswd
usermod -aG wheel "$USER"
echo " Successfly user created "
# ==========================================================================
#               [End :: Configure Accounts]
# ==========================================================================
# ==========================================================================
#               [Start:: Hostname]
# ==========================================================================

echo "Configure hostname"
# Configure hostname and hosts file
echo "$USER" > /etc/hostname
cat << EOF > /etc/hosts
127.0.0.1   localhost
::1     localhost
127.0.1.1   archpc
EOF
echo " HostName successfully Configure"
# ==========================================================================
#               [End:: Hostname]
# ==========================================================================
==========================================================================
#               [Start:: Installing GRUB && Depandency]
# ==========================================================================

#  Create boot dir and mount in it
echo "Creating boot directory"
mkdir /boot/efi
mount -t fat "/dev/$EFI_PARTITION" /boot/efi
echo "Successfly Mounted & created /boot/efi directory !!!!"

#  installing grub and dependency by pacman
echo "installing grub and dependancy"

pacman -S grub efibootmgr os-prober mtools networkmanager network-manager-applet wpa_supplicant dialog base-devel linux-headers  cups openssh blueman git intel-ucode nano vim neovim   --noconfirm
# ==========================================================================
#               [END:: Installing GRUB && Depandency]
# ==========================================================================
# ==========================================================================
#               [Start:: GRUB]
# ==========================================================================

# Bootloader installation (UEFI systems)
echo " install by grub"
grub-install --target=x86_64-efi --bootloader-id=grub_uefi 
echo " get grub confinguration"
grub-mkconfig -o /boot/grub/grub.cfg

# ==========================================================================
#               [End:: GRUB]
# ==========================================================================
# ==========================================================================
#               [Start:: Enabling Syetems]
# ==========================================================================

# Enable essential services
systemctl enable NetworkManager bluetooth cups sshd

# ==========================================================================
#               [End:: Enabling Syetems]
# ==========================================================================


# Get user confirmation before proceeding
read -r -p "Archlinux installed do you like exit ? [y/N] " response
if [[ ! $response =~ ^([Yy]$) ]]; then
  exit 0
fi
echo
echo

exit

# Get user confirmation before proceeding
read -r -p "we will un mount /mnt its ok…! ? [y/N] " response
if [[ ! $response =~ ^([Yy]$) ]]; then
  exit 0
fi
echo
echo

umount -R /mnt 
echo " unmounter /mnt"
echo
echo
# Get user confirmation before proceeding
read -r -p "Reboot…! ? [y/N] " response
if [[ ! $response =~ ^([Yy]$) ]]; then
  exit 0
fi

shutdown -h now
