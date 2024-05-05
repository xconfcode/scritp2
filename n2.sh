#!/usr/bin/env bash


cat <<"EOF"


██╗████████╗    ██████╗ ██████╗  ██████╗ 
██║╚══██╔══╝    ██╔══██╗██╔══██╗██╔═══██╗
██║   ██║       ██████╔╝██████╔╝██║   ██║
██║   ██║       ██╔═══╝ ██╔══██╗██║   ██║
██║   ██║       ██║     ██║  ██║╚██████╔╝
╚═╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝ ╚═════╝ 
                                         
                                                                                                                                                           
   

EOF
time sleep 5



echo "Please enter your username"
read USER 

echo "Please enter your password"
read PASSWORD 

echo -e "\nEnter root password"  # Newline with echo -e
passwd

echo "Please enter your HostName"
read HostName 

echo "uncomment for profile wheels"
EDITOR=nano visudo

echo -e "\n Storred succefully\n" 
time sleep 3
pacman -Syy archlinux-keyring --needed --noconfirm
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
sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^#en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 3
clear
locale-gen
hwclock --systohc
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo arch-pc > /etc/hostname
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 3
clear
# ==========================================================================
#               [Start ::  Configure Accounts]
# ==========================================================================
echo -e "\nstart creating user...\n"
useradd -m -s /bin/bash "$USER"
echo "$USER:$PASSWORD" | chpasswd
usermod -aG wheel "$USER"
echo -e "\nSuccessfly user created...\n "
# ==========================================================================
#               [End :: Configure Accounts]
# ==========================================================================
# ==========================================================================
#               [Start:: Hostname]
# ==========================================================================
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
# ==========================================================================
#               [Installing GRUB && Depandency]
# ==========================================================================

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
#               [ GRUB]
# ==========================================================================

# Bootloader installation (UEFI systems)
echo -e "\n install by grub...\n"
grub-install --target=x86_64-efi --bootloader-id=grub_uefi 

echo -e "\nggrub install bootloader !!!!....\n"

time sleep 3
clear

echo -e "\nget grub confinguration...\n"
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "\ngrub take configuration !!!!....\n"

time sleep 3
clear


pacman -S nvidia nvidia-utils --needed --noconfirm
echo -e "\ninstalled video driver !!!!....\n"

time sleep 3
clear

# ==========================================================================
#               [Enabling Syetems]
# ==========================================================================

# Enable essential services
systemctl enable NetworkManager bluetooth cups sshd

clear 
echo -e "\nenabled NetworkManager !!!!....\n"
echo -e "\nenabled bluetooth !!!!....\n"
echo -e "\nenabled cups !!!!....\n"
echo -e "\nenabled sshd !!!!....\n"

echo -e "\nAll system enabled !!!!....\n"

time sleep 3
