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

echo -e "\n Storred succefully\n" 
time sleep 5
pacman -Syy archlinux-keyring --needed --noconfirm
# ==========================================================================
#               [Start:: generate lang && Time]
# ==========================================================================

# Time

echo -e "\nSetting Times...\n"
ln -sf /usr/share/zoneinfo/America/New_York   /etc/localtime
clear
echo -e "\nSuccessfly configure Times....\n"

time sleep 5

sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sudo sed -i 's/^#en_US ISO-8859-1/en_US ISO-8859-1/' /etc/locale.gen
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 5
locale-gen
hwclock --systohc
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo arch-pc > /etc/hostname
echo -e "\nSuccessfly Uncomment for locale-gen....\n"

time sleep 5
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

echo -e "\nConfigure hostname...\n"
# Configure hostname and hosts file


echo "$HostName" > /etc/hostname
cat << EOF > /etc/hosts
127.0.0.1   localhost
::1     localhost
127.0.1.1   $HostName
EOF
echo -e "\nHostName successfully Configure...\n"

# ==========================================================================
#               [Installing GRUB && Depandency]
# ==========================================================================

#  Create boot dir and mount in it

pacman -S grub efibootmgr os-prober mtools networkmanager network-manager-applet wpa_supplicant dialog base-devel linux-headers  cups openssh blueman git intel-ucode nano vim neovim   --noconfirm

echo "Creating boot directory"
mkdir /boot/efi
mount  /dev/sda1 /boot/efi
echo "Successfly Mounted & created /boot/efi directory !!!!"

#  installing grub and dependency by pacman
echo "installing grub and dependancy"

# ==========================================================================
#               [ GRUB]
# ==========================================================================

# Bootloader installation (UEFI systems)
echo -e "\n install by grub...\n"
grub-install --target=x86_64-efi --bootloader-id=grub_uefi 
echo -e "\nget grub confinguration...\n"
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S nvidia nvidia-utils --needed --noconfirm


# ==========================================================================
#               [Enabling Syetems]
# ==========================================================================

# Enable essential services
systemctl enable NetworkManager bluetooth cups sshd
