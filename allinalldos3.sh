#!/usr/bin/env bash
clear
echo -e "\033[32m"  # Start green text

# ==================================================================================

# [[ START :: header]]

# ==================================================================================



header1="
====================================================================================================================================================

[[ 1. install key ]] 

====================================================================================================================================================
"

header2="
====================================================================================================================================================

[[ 3. CREATE-PARTITIONS ]] 

====================================================================================================================================================
"

header3="
====================================================================================================================================================

[[ 2. USER-INPUT ]] 

====================================================================================================================================================
"

header4="
====================================================================================================================================================

[[  4. FORMAT-PARTITIONS ]] 

====================================================================================================================================================
"


header5="
====================================================================================================================================================

[[ 5. MOUNT-FILE-SYSTEM ]] 

====================================================================================================================================================
"

header6="
====================================================================================================================================================

[[ 6. INSTALL-KERNAL-BASE-PACKAGES ]] 

====================================================================================================================================================
"

header7="
====================================================================================================================================================

[[ 7. STORING-MOUNT]] 

====================================================================================================================================================
"

header8="
====================================================================================================================================================

[[ 8. ARCH-CHROOT]] 

====================================================================================================================================================
"

header9="
====================================================================================================================================================

[[ 9. CREATE-CHROOT-SCRIPT ]] 

====================================================================================================================================================
"

header10="
====================================================================================================================================================

[[ 10. USER-PERMISSION ]] 

====================================================================================================================================================
"

header11="
====================================================================================================================================================

[[ 11. GENERATE-LANG-AND-TIME ]] 

====================================================================================================================================================
"

header12="
====================================================================================================================================================

[[ 12. CREATE-USER ]] 

====================================================================================================================================================
"

header13="
====================================================================================================================================================

[[ 13. HOST-CONFIG ]] 

====================================================================================================================================================
"

header14="
====================================================================================================================================================

[[ 14. INSTALL-GRUB-AND-DEPENDANCY ]] 

====================================================================================================================================================
"

header15="
====================================================================================================================================================

[[ 15. INSTALL-GRUB-BOOTLOADER ]] 

====================================================================================================================================================
"

header16="
====================================================================================================================================================

[[ 16. ENABLING-SYSTEMES ]] 

====================================================================================================================================================
"


# ==================================================================================

# [[ END :: header]]

# ==================================================================================

clear 
echo -e "\033[32m"  # Start green text
echo "$header1"
echo -e "\nkey_activation for arch linux....\n"
pacman-key --init
pacman-key --populate
pacman -Syy archlinux-keyring --noconfirm

echo -e "Successfully archlinux keyring attached...."

time sleep 3


# ==================================================================================
# [[ 2. CREATE-PARTITIONS ]] 
# ==================================================================================
clear 
echo -e "\033[32m"  # Start green text
echo "$header2" 




echo -e "\nCheck and configured Partiion....\n"
sudo cfdisk
clear
time sleep 3 









# ==================================================================================
# [[ 3. USER-INPUT ]] 
# ==================================================================================
clear 
echo -e "\033[32m"  # Start green text
echo "$header3"
echo


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



# ==================================================================================
# [[  4. FORMAT-PARTITIONS ]] 
# ==================================================================================
# make filesystems
clear 
echo -e "\033[32m"  # Start green text
echo "$header4" 



echo -e "\nCreating Filesystems...\n"
echo -e "\nFormatting Desks\n"
mkfs.fat -F32 /dev/"${EFI}"
mkswap /dev/"${SWAP}"
swapon /dev/"${SWAP}"
mkfs.ext4 /dev/"${ROOT}"
echo -e "\nSuccessfully Formatted\n"
time sleep 3




# ==================================================================================
# [[ 5. MOUNT-FILE-SYSTEM ]] 
# ==================================================================================
clear 
echo -e "\033[32m"  # Start green text
echo "$header5" 


echo -e "\nstarted Mounting\n"
mount  /dev/"${ROOT}" /mnt
mkdir /boot/efi
mount  /dev/"${EFI}" /boot/efi
echo -e "\nSuccessfully Mounted\n"
time sleep 3

clear 


# ==========================================================================
# [[ 6. INSTALL-KERNAL-BASE-PACKAGES ]] 
# ==========================================================================
echo -e "\033[32m"  # Start green text
echo "$header5" 



echo -e "\nInstalling Base system into Linux kernal ...\n"
# Install base system (remove --noconfirm for manual confirmation)
echo -e "\nInstalling Arch Linux base...\n"
pacstrap -K /mnt base linux linux-firmware sudo nano
 
echo "Installed successsfly  Base system into Linux kernal !!!!"
time sleep 3

clear






# ==========================================================================
# [[ 7. STORING-MOUNT]]       
# ==========================================================================
echo -e "\033[32m"  # Start green text
echo "$header7" 


# Generate Mount
echo " Storring mount"
genfstab -U /mnt >> /mnt/etc/fstab
echo "Successfly storred all mount"
time sleep 3

clear


# ==========================================================================

# ==========================================================================
# [[ 8. ARCH-CHROOT ]]      
# ==========================================================================
echo -e "\033[32m"  # Start green text
echo "$header8" 




echo "copy arch-chroot scripts"
# curl https://raw.githubusercontent.com/xconfcode/scritp2/main/n2.sh -o /mnt/n2.sh && chmod +x  /mnt/n2.sh
echo
time sleep 3

# ============================================
# copy arch-chroot
# ============================================
clear
echo -e "\033[32m"  # Start green text
echo "$header9" 





cat <<REALEND > /mnt/n2.sh

#!/usr/bin/env bash
clear


# ============================================
# copy arch-chroot
# ============================================

echo -e "\033[32m"  # Start green text
echo "$header10" 


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


# ==========================================================================
#  [[ 11. GENERATE-LANG-AND-TIME ]] 
# ==========================================================================

# Time

clear
echo -e "\033[32m"  # Start green text
echo "$header11" 


echo -e "\nSetting Times...\n"
ln -sf /usr/share/zoneinfo/America/New_York   /etc/localtime
clear
echo -e "\nSuccessfly configure Times....\n"

time sleep 3
clear



echo -e "\033[32m"  # Start green text




sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^#en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 3
clear


echo -e "\033[32m"  # Start green text




locale-gen
hwclock --systohc
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo arch-pc > /etc/hostname
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 3
clear





# ==========================================================================
# [[ 12. CREATE-USER ]] 
# ==========================================================================
clear
echo -e "\033[32m"  # Start green text
echo "$header12" 


echo -e "\nEnter root password"  # Newline with echo -e
passwd
echo -e "\nstart creating user...\n"
useradd -m -s /bin/bash "$USER"
echo "$USER:$PASSWORD" | chpasswd
usermod -aG wheel "$USER"
echo -e "\nSuccessfly user created...\n "




clear

# ==========================================================================
# [[ 13. HOST-CONFIG ]] 
# ==========================================================================
clear
echo -e "\033[32m"  # Start green text
echo "$header13" 







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


# ==========================================================================
# [[ 14. INSTALL-GRUB-AND-DEPENDANCY ]] 
# ==========================================================================

echo -e "\033[32m"  # Start green text
echo "$header14" 


#  Create boot dir and mount in it

echo -e "\nInstalling grub and dependencies...\n"
pacman -S grub efibootmgr os-prober mtools networkmanager network-manager-applet wpa_supplicant dialog base-devel linux-headers  cups openssh blueman git intel-ucode nano vim neovim   --noconfirm
echo -e "\nSuccessfly installed grub & dependancy....\n"

time sleep 3
clear


echo "Creating boot directory"
mkdir /boot/efi
mount  /dev/sda1 /boot/efi
echo "Successfly Mounted & created /boot/efi directory !!!!"
time sleep 3
clear



#  installing grub and dependency by pacman
echo "installing grub and dependancy"
time sleep 3


# ==========================================================================
#  [[ 15. INSTALL-GRUB-BOOTLOADER ]] 
# ==========================================================================
clear


echo -e "\033[32m"  # Start green text
echo "$header15" 





# Bootloader installation (UEFI systems)
echo -e "\n install by grub...\n"
grub-install --target=x86_64-efi --bootloader-id=grub_uefi 

echo -e "\nggrub install bootloader !!!!....\n"

time sleep 3
clear



echo -e "\033[32m"  # Start green text






echo -e "\nget grub confinguration...\n"
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\ngrub take configuration !!!!....\n"

time sleep 3
clear






# ==========================================================================
#  [[ 15. INSTALL-GRAPHIC ]] 
# ==========================================================================
clear


echo -e "\033[32m"  # Start green text
echo "$header15"


pacman -S nvidia nvidia-utils  xf86-video-intel --needed --noconfirm
echo -e "\ninstalled video driver !!!!....\n"

time sleep 3
clear

# ==========================================================================
# [[ 16. ENABLING-SYSTEMES ]] 
# ==========================================================================
clear
echo -e "\033[32m"  # Start green text
echo "$header16"

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
echo -e "\033[32m"  # Start green text
chmod +x  /mnt/n2.sh
echo -e "\narch-chroot scipt excuteded successfully !!!!....\n"
time sleep 3
arch-chroot /mnt /bin/bash /n2.sh
time sleep 3

