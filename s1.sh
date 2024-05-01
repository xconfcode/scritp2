#!/usr/bin/env bash

# ==========================================================================
#               [Start:: Confim]
# ==========================================================================


# Get user confirmation before proceeding
read -r -p "This script will install Arch Linux. Are you sure? [y/N] " response
if [[ ! $response =~ ^([Yy]$) ]]; then
  exit 0
fi

# Define helper functions
function get_partition {
  local prompt="$1"
  read -r -p "$prompt: " partition
  while [[ -z "$partition" ]]; do
    read -r -p "Invalid partition. Please enter again: " partition
  done
  echo "$partition"
}

# ==========================================================================
#               [End:: Confim]
# ==========================================================================



# ==========================================================================
#               [Start:: Partition]
# ==========================================================================

# Get partition details with error handling
EFI_PARTITION=$(get_partition "Enter EFI partition (e.g., /sda1)")
SWAP_PARTITION=$(get_partition "Enter swap partition (e.g., /sda2)")
ROOT_PARTITION=$(get_partition "Enter root partition (e.g., /sda3)")

# Formatting Partion [start]
echo "Starting Formatting Partition"

 #Informative messages
echo "Creating filesystems..."
echo "WARNING: Make sure you selected the correct partitions!"

# Create filesystems (use confirm_and_run for safety)
echo "Create filesystems .................!"
mkfs.fat -F32 -n \"EFISYSTEM\" \"/dev/$EFI_PARTITION\"
mkswap \"/dev/$SWAP_PARTITION\"
swapon "/dev/$SWAP_PARTITION"
mkfs.ext4 -L  \"ROOT\" \"/dev/$ROOT_PARTITION\"
echo "Successfly Formatted Partition !!!!"

# ==========================================================================
#               [END:: Partition]
# ==========================================================================

# ==========================================================================
#               [Start:: Mounting]
# ==========================================================================

# Mount target directories

echo "start mounting  into root partition...."
pacman-key –init && pacman-key --populate && pacman -Syy archlinux-keyring --noconfirm
mount -t ext4 "/dev/$ROOT_PARTITION" /mnt
echo "Successfly Mounted & created /boot/efi directory !!!!"
# ==========================================================================
#               [END:: Mounting]
# ==========================================================================
# ==========================================================================
#               [Start:: Kernal base package]
# ==========================================================================
echo "Installing Base system into Linux kernal ......"
# Install base system (remove --noconfirm for manual confirmation)
echo "Installing Arch Linux base..."
pacstrap -K /mnt base linux linux-firmware sudo nano
 
echo "Installed successsfly  Base system into Linux kernal !!!!"
# ==========================================================================
#               [END::Kernal base package]
# ==========================================================================
# ==========================================================================
#               [Start:: Storing Mount]
# ==========================================================================

# Generate Mount
echo " Storring mount"
genfstab -U /mnt >> /mnt/etc/fstab
echo "Successfly storred all mount"
# ==========================================================================
#               [End:: Storing Mount]
# ==========================================================================














