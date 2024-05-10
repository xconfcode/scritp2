#!/usr/bin/env bash
clear
echo -e "\033[32m"  # Start green text

# ==================================================================================

# [[ START :: header]]

# ==================================================================================



header1=$(<<'EOF'
====================================================================================================================================================
[[ 1. install key ]] 

====================================================================================================================================================
EOF)

header2=$(<<'EOF'
====================================================================================================================================================
[[ 2. USER-INPUT ]] 

====================================================================================================================================================
EOF)


header3=$(<<'EOF'
====================================================================================================================================================
[[ 3. CREATE-PARTITIONS ]] 

====================================================================================================================================================
EOF)



header4=$(<<'EOF'
====================================================================================================================================================
[[  4. FORMAT-PARTITIONS ]] 

====================================================================================================================================================
EOF)


header5=$(<<'EOF'
====================================================================================================================================================
[[ 5. MOUNT-FILE-SYSTEM ]] 

====================================================================================================================================================
EOF)

header6=$(<<'EOF'
====================================================================================================================================================
[[ 6. INSTALL-KERNAL-BASE-PACKAGES ]] 

====================================================================================================================================================
EOF)

header7=$(<<'EOF'
====================================================================================================================================================
[[ 7. STORING-MOUNT]] 

====================================================================================================================================================
EOF)

header8=$(<<'EOF'
====================================================================================================================================================
[[ 8. ARCH-CHROOT]] 

====================================================================================================================================================
EOF)

header9=$(<<'EOF'
====================================================================================================================================================
[[ 9. CREATE-CHROOT-SCRIPT ]] 

====================================================================================================================================================
EOF)

header10=$(<<'EOF'
====================================================================================================================================================
[[ 10. USER-PERMISSION ]] 

====================================================================================================================================================
EOF)

header11=$(<<'EOF'
====================================================================================================================================================
[[ 11. GENERATE-LANG-AND-TIME ]] 

====================================================================================================================================================
EOF)

header12=$(<<'EOF'
====================================================================================================================================================
[[ 12. CREATE-USER ]] 

====================================================================================================================================================
EOF)

header13=$(<<'EOF'
====================================================================================================================================================
[[ 13. HOST-CONFIG ]] 

====================================================================================================================================================
EOF)

header14=$(<<'EOF'
====================================================================================================================================================
[[ 14. INSTALL-GRUB-AND-DEPENDANCY ]] 

====================================================================================================================================================
EOF)

header15=$(<<'EOF'
====================================================================================================================================================
[[ 15. INSTALL-GRUB-BOOTLOADER ]] 

====================================================================================================================================================
EOF)

header16=$(<<'EOF'
====================================================================================================================================================
[[ 16. ENABLING-SYSTEMES ]] 

====================================================================================================================================================
EOF)


# ==================================================================================

# [[ END :: header]]

# ==================================================================================


echo "$header1"

 
echo "Press Enter to continue..."
read -r
echo "Continuing..."


# Reset text color
echo -e "\033[0m"  # Reset to default color

echo -e "\nkey_activation for arch linux....\n"
pacman-key --init
pacman-key --populate
pacman -Syy archlinux-keyring --noconfirm

echo -e "\nSuccessfully archlinux keyring attached....\n"
time sleep 3
clear 
echo -e "\033[32m"  # Start green text

# ==================================================================================
# [[ 2. USER-INPUT ]] 
# ==================================================================================

echo "$header2"
echo
echo "Press Enter to continue..."
read -r
echo "Continuing..."



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



echo "Please enter your HostName"
read HostName 

echo -e "\nSuccessfully Store user input....\n"
time sleep 3

clear 

echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color


# ==================================================================================
# [[ 3. CREATE-PARTITIONS ]] 
# ==================================================================================

echo "$header3" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."



# Reset text color
echo -e "\033[0m"  # Reset to default color

echo -e "\nCheck and configured Partiion....\n"
sudo cfdisk
clear
time sleep 3 
echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color




# ==================================================================================
# [[  4. FORMAT-PARTITIONS ]] 
# ==================================================================================
# make filesystems

echo "$header4" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."


echo -e "\nCreating Filesystems...\n"
echo -e "\nFormatting Desks\n"
mkfs.fat -F32 /dev/"${EFI}"
mkswap /dev/"${SWAP}"
swapon /dev/"${SWAP}"
mkfs.ext4 /dev/"${ROOT}"
echo -e "\nSuccessfully Formatted\n"
time sleep 3
clear
echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color

# ==================================================================================
# [[ 5. MOUNT-FILE-SYSTEM ]] 
# ==================================================================================
echo "$header5" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."


echo -e "\nstarted Mounting\n"
mount  /dev/"${ROOT}" /mnt
mkdir /boot/efi
mount  /dev/"${EFI}" /boot/efi
echo -e "\nSuccessfully Mounted\n"
time sleep 3

clear 
echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color

# ==========================================================================
# [[ 6. INSTALL-KERNAL-BASE-PACKAGES ]] 
# ==========================================================================
echo "$header5" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."


echo -e "\nInstalling Base system into Linux kernal ...\n"
# Install base system (remove --noconfirm for manual confirmation)
echo -e "\nInstalling Arch Linux base...\n"
pacstrap -K /mnt base linux linux-firmware sudo nano
 
echo "Installed successsfly  Base system into Linux kernal !!!!"
time sleep 3

clear
echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color

# ==========================================================================
# [[ 7. STORING-MOUNT]]       
# ==========================================================================
echo "$header7" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."


# Generate Mount
echo " Storring mount"
genfstab -U /mnt >> /mnt/etc/fstab
echo "Successfly storred all mount"
time sleep 3

clear
echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color

# ==========================================================================

# ==========================================================================
# [[ 8. ARCH-CHROOT ]]      
# ==========================================================================
echo "$header8" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."


echo "copy arch-chroot scripts"
# curl https://raw.githubusercontent.com/xconfcode/scritp2/main/n2.sh -o /mnt/n2.sh && chmod +x  /mnt/n2.sh
echo
time sleep 3

# ============================================
# copy arch-chroot
# ============================================
echo "$header9" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."



cat <<REALEND > /mnt/n2.sh

#!/usr/bin/env bash
clear


# ============================================
# copy arch-chroot
# ============================================

echo "$header10" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color


echo "uncomment for profile wheels"
# 
echo -e "\n changing Permission" 

sudo sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers.tmp
echo -e "\nUncommented s/^# %wheel ALL=(ALL:ALL) successfully \n"
time sleep 5 
echo -e "\nCheck if Uncommented s/^# %wheel ALL=(ALL:ALL) successfully \n"
time sleep 3
EDITOR=nano visudo 






echo -e "\n Storred succefully\n" 
time sleep 3
#pacman -Syy archlinux-keyring --needed --noconfirm
clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color
# ==========================================================================
#  [[ 11. GENERATE-LANG-AND-TIME ]] 
# ==========================================================================

# Time

clear
echo "$header11" 
echo -e "\033[32m"  # Start green text

echo "Press Enter to continue..."
read -r
echo "Continuing..."





# Reset text color
echo -e "\033[0m"  # Reset to default color
echo -e "\nSetting Times...\n"
ln -sf /usr/share/zoneinfo/America/New_York   /etc/localtime
clear
echo -e "\nSuccessfly configure Times....\n"

time sleep 3
clear
clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color
sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^#en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 3
clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color
locale-gen
hwclock --systohc
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo arch-pc > /etc/hostname
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 3
clear
clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color
# ==========================================================================
# [[ 12. CREATE-USER ]] 
# ==========================================================================
clear

echo "$header12" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."




echo -e "\nEnter root password"  # Newline with echo -e
passwd
echo -e "\nstart creating user...\n"
useradd -m -s /bin/bash "$USER"
echo "$USER:$PASSWORD" | chpasswd
usermod -aG wheel "$USER"
echo -e "\nSuccessfly user created...\n "
clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color



# ==========================================================================
# [[ 13. HOST-CONFIG ]] 
# ==========================================================================
clear
clear
echo "$header13" 

echo -e "\033[32m"  # Start green text


echo "Press Enter to continue..."
read -r
echo "Continuing..."




# Reset text color
echo -e "\033[0m"  # Reset to default color
echo -e "\nConfigure hostname...\n"
# Configure hostname and hosts file


echo "$HostName" > /etc/hostname
cat << EOF > /etc/hosts
127.0.0.1   localhost
::1     localhost
127.0.1.1   $HostName
EOF
echo -e "\nHostName successfully Configure...\n"


time sleep 3
clear
clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color
# ==========================================================================
# [[ 14. INSTALL-GRUB-AND-DEPENDANCY ]] 
# ==========================================================================

echo "$header14" 


echo "Press Enter to continue..."
read -r
echo "Continuing..."


#  Create boot dir and mount in it

echo -e "\nInstalling grub and dependencies...\n"
pacman -S grub efibootmgr os-prober mtools networkmanager network-manager-applet wpa_supplicant dialog base-devel linux-headers  cups openssh blueman git intel-ucode nano vim neovim   --noconfirm
echo -e "\nSuccessfly installed grub & dependancy....\n"

time sleep 3
clear

clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color


echo "Creating boot directory"
mkdir /boot/efi
mount  /dev/sda1 /boot/efi
echo "Successfly Mounted & created /boot/efi directory !!!!"
time sleep 3
clear
clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color

#  installing grub and dependency by pacman
echo "installing grub and dependancy"
time sleep 3

# ==========================================================================
#  [[ 15. INSTALL-GRUB-BOOTLOADER ]] 
# ==========================================================================
clear


echo -e "\033[32m"  # Start green text

echo "$header15" 

echo "Press Enter to continue..."
read -r
echo "Continuing..."



# Reset text color
echo -e "\033[0m"  # Reset to default color


# Bootloader installation (UEFI systems)
echo -e "\n install by grub...\n"
grub-install --target=x86_64-efi --bootloader-id=grub_uefi 

echo -e "\nggrub install bootloader !!!!....\n"

time sleep 3
clear
clear


echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color


echo -e "\nget grub confinguration...\n"
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\ngrub take configuration !!!!....\n"

time sleep 3
clear
clear




# ==========================================================================
#  [[ 15. INSTALL-GRAPHIC ]] 
# ==========================================================================
echo -e "\033[32m"  # Start green text

echo "$header15"

echo "Press Enter to continue..."
read -r
echo "Continuing..."



# Reset text color
echo -e "\033[0m"  # Reset to default color
pacman -S nvidia nvidia-utils  xf86-video-intel --needed --noconfirm
echo -e "\ninstalled video driver !!!!....\n"

time sleep 3
clear

# ==========================================================================
# [[ 16. ENABLING-SYSTEMES ]] 
# ==========================================================================
clear

echo "$header16"

echo "Press Enter to continue..."
read -r
echo "Continuing..."



echo -e "\033[32m"  # Start green text



# Reset text color
echo -e "\033[0m"  # Reset to default color
# Enable essential services
systemctl enable NetworkManager bluetooth cups sshd

clear 
echo -e "\nenabled NetworkManager !!!!....\n"
echo -e "\nenabled bluetooth !!!!....\n"
echo -e "\nenabled cups !!!!....\n"
echo -e "\nenabled sshd !!!!....\n"

echo -e "\nAll system enabled !!!!....\n"
echo -e "\nInstallation complete. Reboot using 'reboot' !!!!....\n"
echo -e "\nDont forget typr umount -R /mnt.....!!!!....\n"

time sleep 3
EOF

REALEND

# =========================================
# END-CHROOT
# =========================================
# Chroot and execute configuration script
chmod +x  /mnt/n2.sh
echo -e "\narch-chroot scipt excuteded successfully !!!!....\n"
time sleep 3
arch-chroot /mnt /bin/bash /n2.sh
time sleep 3

