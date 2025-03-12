#!/usr/bin/env bash
clear
echo -e "\033[32m"  # Start green text
clear
echo -e "\033[32m"  # Start green text
INSTALL_ARCH_LICENSE_KEY="
====================================================================================================================================================
[[ 1. install key ]]
====================================================================================================================================================
"
echo "$INSTALL_ARCH_LICENSE_KEY"
echo -e "\nkey_activation for arch linux && updating.....\n"
pacman-key --init && pacman-key --populate
echo -e "\033[32m"  # Start green text
echo -e "================================================="
echo -e ""
echo -e "\nInstalling keys....\n"
echo -e ""
pacman -Syy archlinux-keyring --needed --noconfirm
echo -e "================================================="
echo -e ""
echo -e "\033[32m"  # Start green text
echo -e "\nSuccessfully archlinux keyring attached....!!!!!\n"
echo -e ""
echo -e "\033[32m"  # Start green text
echo -e "================================================="
time sleep 3
clear
echo -e "\033[32m"  # Start green text
CREATE_PARTITIONS="
====================================================================================================================================================
[[ 3. CREATE-PARTITIONS ]]
====================================================================================================================================================
"
echo "$CREATE_PARTITIONS"
echo -e "\nCheck and configured Partiion....\n"
sudo cfdisk
clear
time sleep 3
# ==================================================================================
# [[ 3. USER-INPUT ]]
# ==================================================================================
clear
echo -e "\033[32m"  # Start green text
USER_INPUT="
====================================================================================================================================================
[[ 2. USER-INPUT ]]
====================================================================================================================================================
"
echo "$USER_INPUT"
echo -e ""
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
# make filesystems
clear
echo -e "\033[32m"  # Start green text
FORMATING_THE_PARTITIONS="
====================================================================================================================================================
[[  4. FORMAT-PARTITIONS ]]
====================================================================================================================================================
"
echo "$FORMATING_THE_PARTITIONS"
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
MOUNT_FILE_SYSTEM="
====================================================================================================================================================
[[ 5. MOUNT-FILE-SYSTEM ]]
====================================================================================================================================================
"
echo "$MOUNT_FILE_SYSTEM"
echo -e "\nstarted Mounting\n"
mount  /dev/"${ROOT}" /mnt
mkdir /boot/efi
mount  /dev/"${EFI}" /boot/efi
echo -e "\nSuccessfully Mounted\n"
time sleep 3
clear
clear
echo -e "\033[32m"  # Start green text
INSTALL_KERNAL_BASE_APP="
====================================================================================================================================================
[[ 6. INSTALL-KERNAL-BASE-PACKAGES ]]
====================================================================================================================================================
"
echo "$INSTALL_KERNAL_BASE_APP"
echo -e  ""
echo -e "Installing Base system into Linux kernal ..."
echo -e  ""
echo -e  ""
echo -e "Installing Arch Linux base..."
pacstrap -K /mnt base linux linux-firmware sudo nano
 echo -e "\033[32m"  # Start green text
echo "Installed successsfly  Base system into Linux kernal !!!!"
time sleep 3
clear
echo -e "\033[32m"  # Start green text
STORING_MOUNT_PATH="
====================================================================================================================================================
[[ 7. STORING-MOUNT-PATH]]
====================================================================================================================================================
"
echo "$STORING_MOUNT_PATH"
# Generate Mount
echo " Storring Mount PATH"
genfstab -U /mnt >> /mnt/etc/fstab
echo "Successfly storred all mount"
time sleep 3
clear
echo -e "\033[32m"  # Start green text
ARCH_CHROOT="
====================================================================================================================================================
[[ 8. ARCH-CHROOT]]
====================================================================================================================================================
"
echo "$ARCH_CHROOT"
echo "copy arch-chroot scripts"
 curl https://raw.githubusercontent.com/xconfcode/scritp2/main/INSTALL.sh -o /mnt/INSTALL.sh && chmod +x  /mnt/INSTALL.sh
echo
time sleep 3
# ============================================
# copy arch-chroot
# ============================================
clear
echo -e "\033[32m"  # Start green text
CREATE_CHROOT_SCRIPT="
====================================================================================================================================================
[[ 9. CREATE-CHROOT-SCRIPT ]]
====================================================================================================================================================
"
echo "$CREATE_CHROOT_SCRIPT"
cat <<REALEND > /mnt/INSTALL.sh
#!/usr/bin/env bash
clear
# ============================================
# copy arch-chroot
# ============================================
echo -e "\033[32m"  # Start green text
SET_USER_PERMISSION="
====================================================================================================================================================
[[ 10. USER-PERMISSION ]]
====================================================================================================================================================
"
echo "$SET_USER_PERMISSION"
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
SET_LANGUAGE_AND_DATE="
====================================================================================================================================================
[[ 11. GENERATE-LANG-AND-TIME ]]
====================================================================================================================================================
"
echo "$SET_LANGUAGE_AND_DATE"
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
CREATE_USER="
====================================================================================================================================================
[[ 12. CREATE-USER ]]
====================================================================================================================================================
"
echo "$CREATE_USER"
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
HOST_CONFIG="
====================================================================================================================================================

[[ 13. HOST-CONFIG ]]

====================================================================================================================================================
"
echo "$HOST_CONFIG"
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
INSTALL_GRUB_AND_DEPENDANCY="
====================================================================================================================================================

[[ 14. INSTALL-GRUB-AND-DEPENDANCY ]]

====================================================================================================================================================
"
echo "$INSTALL_GRUB_AND_DEPENDANCY"
#  Create boot dir and mount in it
echo -e "\nInstalling grub and dependencies...\n"
# pacman -S grub efibootmgr os-prober mtools networkmanager network-manager-applet wpa_supplicant dialog base-devel linux-headers  cups openssh blueman git intel-ucode nano vim neovim   --noconfirm
pacman -S grub efibootmgr os-prober mtools networkmanager    --noconfirm
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
INSTALL_GRUB_BOOTLOADER="
====================================================================================================================================================

[[ 15. INSTALL-GRUB-BOOTLOADER ]]

====================================================================================================================================================
"
echo "$INSTALL_GRUB_BOOTLOADER"
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
echo "INSTALL_GRAPHIC"
pacman -S nvidia nvidia-utils  xf86-video-intel --needed --noconfirm
echo -e "\ninstalled video driver !!!!....\n"
time sleep 3
clear
# ==========================================================================
# [[ 16. ENABLING-SYSTEMES ]]
# ==========================================================================
clear
echo -e "\033[32m"  # Start green text
ENABLING_SYSTEMES="
====================================================================================================================================================

[[ 16. ENABLING-SYSTEMES ]]

====================================================================================================================================================
"
echo "$ENABLING_SYSTEMES"
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
chmod +x  /mnt/INSTALL.sh
echo -e "\narch-chroot scipt excuteded successfully !!!!....\n"
time sleep 3
arch-chroot /mnt /bin/bash /INSTALL.sh
time sleep 3
