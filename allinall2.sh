#!/usr/bin/env bash
clear
# echo -e "\033[32m"  # Start green text

header="
██╗████████╗    ██████╗ ██████╗  ██████╗ 
██║╚══██╔══╝    ██╔══██╗██╔══██╗██╔═══██╗
██║   ██║       ██████╔╝██████╔╝██║   ██║
██║   ██║       ██╔═══╝ ██╔══██╗██║   ██║
██║   ██║       ██║     ██║  ██║╚██████╔╝
╚═╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝ ╚═════╝ 
      Welcome to the Arch Linux Installation Script!
"

clear
tput cup 0 0  # Move cursor to top-left corner
echo -e "\033[2J\033[1;1H"  # Clear screen and move cursor to top-left corner

clear          # Clear the screen
echo -e "\033[2J\033[1;1H"  # Clear screen and move cursor to top-left corner

echo "$header"





echo -e "\nkey_activation for arch linux....\n"
pacman-key --init
pacman-key --populate
pacman -Syy archlinux-keyring --noconfirm

echo -e "\nSuccessfully archlinux keyring attached....\n"
time sleep 3
clear 
# echo -e "\033[32m"  # Start green text





echo -e "\nCheck and configured Partiion....\n"
sudo cfdisk
clear
time sleep 3 
# echo -e "\033[32m"  # Start green text




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

echo "Please enter your HostName"
read HostName 

echo -e "\nSuccessfully Store user input....\n"
time sleep 3

clear 




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
clear
# echo -e "\033[32m"  # Start green text





# ==================================================================================
# [[ Mounting ]] 
# ==================================================================================
echo -e "\nstarted Mounting\n"
mount  "${ROOT}" /mnt
mkdir /boot/efi
mount  "${EFI}" /boot/efi
echo -e "\nSuccessfully Mounted\n"
time sleep 3

clear 
# # echo -e "\033[32m"  # Start green text





# ==========================================================================
#   [ Kernal base package]
# ==========================================================================
echo -e "\nInstalling Base system into Linux kernal ...\n"
# Install base system (remove --noconfirm for manual confirmation)
echo -e "\nInstalling Arch Linux base...\n"
pacstrap -K /mnt base linux linux-firmware sudo nano
 
echo "Installed successsfly  Base system into Linux kernal !!!!"
time sleep 3

clear
# echo -e "\033[32m"  # Start green text





# ==========================================================================
#               [Storing Mount]
# ==========================================================================

# Generate Mount
echo " Storring mount"
genfstab -U /mnt >> /mnt/etc/fstab
echo "Successfly storred all mount"
time sleep 3

clear
# echo -e "\033[32m"  # Start green text





# ==========================================================================

echo "copy arch-chroot scripts"
# curl https://raw.githubusercontent.com/xconfcode/scritp2/main/n2.sh -o /mnt/n2.sh && chmod +x  /mnt/n2.sh
echo
time sleep 3

# ============================================
# copy arch-chroot
# ============================================

cat <<REALEND > /mnt/n2.sh

#!/usr/bin/env bash
clear












echo "uncomment for profile wheels"
# EDITOR=nano visudo
echo -e "\n changing Permission" 
read -r -p "Need to uncomment ^# %wheel ALL=(ALL:ALL)  ok ? [y/N] " response
if [[ ! $response =~ ^([Yy]$) ]]; then

  exit 0
fi

visudo



echo -e "\n Storred succefully\n" 
time sleep 3
#pacman -Syy archlinux-keyring --needed --noconfirm
clear




# ==========================================================================
#               [Start:: generate lang && Time]
# ==========================================================================

# Time

clear



echo -e "\nSetting Times...\n"
ln -sf /usr/share/zoneinfo/America/New_York   /etc/localtime
clear
echo -e "\nSuccessfly configure Times....\n"

time sleep 3
clear
clear


# echo -e "\033[32m"  # Start green text




sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^#en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 3
clear


# echo -e "\033[32m"  # Start green text




locale-gen
hwclock --systohc
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo arch-pc > /etc/hostname
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 3
clear
clear


# echo -e "\033[32m"  # Start green text




# ==========================================================================
#               [Start ::  Configure Accounts]
# ==========================================================================
echo -e "\nstart creating user...\n"
useradd -m -s /bin/bash "$USER"
echo "$USER:$PASSWORD" | chpasswd
usermod -aG wheel "$USER"
echo -e "\nSuccessfly user created...\n "
clear





# ==========================================================================
#               [End :: Configure Accounts]
# ==========================================================================
# ==========================================================================
#               [Start:: Hostname]
# ==========================================================================
clear
clear





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





# ==========================================================================
#               [Installing GRUB && Depandency]
# ==========================================================================

#  Create boot dir and mount in it

echo -e "\nInstalling grub and dependencies...\n"
pacman -S grub efibootmgr os-prober mtools networkmanager network-manager-applet wpa_supplicant dialog base-devel linux-headers  cups openssh blueman git intel-ucode nano vim neovim   --noconfirm
echo -e "\nSuccessfly installed grub & dependancy....\n"

time sleep 3
clear

clear







echo "Creating boot directory"
mkdir /boot/efi
mount  /dev/sda1 /boot/efi
echo "Successfly Mounted & created /boot/efi directory !!!!"
time sleep 3
clear
clear





#  installing grub and dependency by pacman
echo "installing grub and dependancy"
time sleep 3

# ==========================================================================
#               [ GRUB]
# ==========================================================================
clear







# Bootloader installation (UEFI systems)
echo -e "\n install by grub...\n"
grub-install --target=x86_64-efi --bootloader-id=grub_uefi 

echo -e "\nggrub install bootloader !!!!....\n"

time sleep 3
clear
clear







echo -e "\nget grub confinguration...\n"
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\ngrub take configuration !!!!....\n"

time sleep 3
clear
clear








pacman -S nvidia nvidia-utils --needed --noconfirm
echo -e "\ninstalled video driver !!!!....\n"

time sleep 3
clear

# ==========================================================================
#               [Enabling Syetems]
# ==========================================================================
clear





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

# Reboot message
'"
echo -e "\nInstallation complete. Reboot using 'reboot' !!!!....\n"
echo -e "\nDont forget typr umount -R /mnt.....!!!!....\n"
time sleep 3