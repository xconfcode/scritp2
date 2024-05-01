#!/usr/bin/env bash
cat <<"EOF"
  _   _   _   _   _   _   _  
 / \ / \ / \ / \ / \ / \ / \ 
( B | u | D | o | k | h | i )
 \_/ \_/ \_/ \_/ \_/ \_/ \_/       

EOF

# ==================================================================================
# [[ get input ]] 
# ==================================================================================
echo "Please enter EFI paritition: (example /dev/sda1 or /dev/nvme0n1p1)"
read EFI

echo "Please enter SWAP paritition: (example /dev/sda2)"
read SWAP

echo "Please enter Root(/) paritition: (example /dev/sda3)"
read ROOT 

echo "Please enter your username"
read USER 

echo "Please enter your password"
read PASSWORD 

echo -e "\nEnter root password"  # Newline with echo -e
passwd

echo -e "\n changing Permission" 
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# ==================================================================================
# [[ PARTITIONS ]] 
# ==================================================================================
# make filesystems
echo -e "\nCreating Filesystems...\n"
echo -e "\nFormatting Desks\n"
mkfs.fat -F32 -n "EFISYSTEM" "${EFI}"
mkswap "${SWAP}"
swapon "${SWAP}"
mkfs.ext4 -L "ROOT" "${ROOT}"
echo -e "\nSuccessfully Formatted\n"

# ==================================================================================
# [[ Mounting ]] 
# ==================================================================================
echo -e "\nstarted Mounting\n"
mount  "${ROOT}" /mnt
mkdir /boot/efi
mount  "${EFI}" /boot/efi
echo -e "\nSuccessfully Mounted\n"

# ==========================================================================
#   [ Kernal base package]
# ==========================================================================
echo -e "\nInstalling Base system into Linux kernal ...\n"
# Install base system (remove --noconfirm for manual confirmation)
echo -e "\nInstalling Arch Linux base...\n"
pacstrap -K /mnt base linux linux-firmware sudo nano
 
echo "Installed successsfly  Base system into Linux kernal !!!!"

# ==========================================================================
#               [Storing Mount]
# ==========================================================================

# Generate Mount
echo " Storring mount"
genfstab -U /mnt >> /mnt/etc/fstab
echo "Successfly storred all mount"
# ==========================================================================

echo "copy arch-chroot scripts"
curl https://raw.githubusercontent.com/xconfcode/scritp2/main/n2.sh -o /mnt/n2.sh && chmod +x  /mnt/n2.sh
echo

# Chroot and execute configuration script
arch-chroot /mnt /bin/bash /n2.sh

# Reboot message
echo "Installation complete. Reboot using 'reboot'"
