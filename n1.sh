#!/usr/bin/env bash
clear
cat <<"EOF"


██╗████████╗    ██████╗ ██████╗  ██████╗ 
██║╚══██╔══╝    ██╔══██╗██╔══██╗██╔═══██╗
██║   ██║       ██████╔╝██████╔╝██║   ██║
██║   ██║       ██╔═══╝ ██╔══██╗██║   ██║
██║   ██║       ██║     ██║  ██║╚██████╔╝
╚═╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝ ╚═════╝ 
                                         
                                                                                                                                                                      
   

EOF
time sleep 3


# ==================================================================================
# [[ get input ]] 
# ==================================================================================
echo "Please enter EFI paritition: (example /dev/sda1 or /dev/nvme0n1p1)"
read EFI

echo "Please enter SWAP paritition: (example /dev/sda2)"
read SWAP

echo "Please enter Root(/) paritition: (example /dev/sda3)"
read ROOT 


#echo -e "\n changing Permission" 
#sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# ==================================================================================
# [[ PARTITIONS ]] 
# ==================================================================================
# make filesystems
echo -e "\nCreating Filesystems...\n"
echo -e "\nFormatting Desks\n"
mkfs.fat -F32 "${EFI}"
mkswap "${SWAP}"
swapon "${SWAP}"
mkfs.ext4 "${ROOT}"
echo -e "\nSuccessfully Formatted\n"
time sleep 3

# ==================================================================================
# [[ Mounting ]] 
# ==================================================================================
echo -e "\nstarted Mounting\n"
mount  "${ROOT}" /mnt
mkdir /boot/efi
mount  "${EFI}" /boot/efi
echo -e "\nSuccessfully Mounted\n"
time sleep 3

# ==========================================================================
#   [ Kernal base package]
# ==========================================================================
echo -e "\nInstalling Base system into Linux kernal ...\n"
# Install base system (remove --noconfirm for manual confirmation)
echo -e "\nInstalling Arch Linux base...\n"
pacstrap -K /mnt base linux linux-firmware sudo nano
 
echo "Installed successsfly  Base system into Linux kernal !!!!"
time sleep 3

# ==========================================================================
#               [Storing Mount]
# ==========================================================================

# Generate Mount
echo " Storring mount"
genfstab -U /mnt >> /mnt/etc/fstab
echo "Successfly storred all mount"
time sleep 3

# ==========================================================================

echo "copy arch-chroot scripts"
curl https://raw.githubusercontent.com/xconfcode/scritp2/main/n2.sh -o /mnt/n2.sh && chmod +x  /mnt/n2.sh
echo

# Chroot and execute configuration script
arch-chroot /mnt /bin/bash /n2.sh
time sleep 3

# Reboot message
echo "Installation complete. Reboot using 'reboot'"
time sleep 3

