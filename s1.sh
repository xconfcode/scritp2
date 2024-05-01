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
function confirm_and_run {
  local command="$1"
  echo "Running: $command"
  read -r -p "Continue? [y/N] " response
  if [[ ! $response =~ ^([Yy]$) ]]; then
    exit 1
  fi
  eval "$command"
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
# Formatting Partion [start]
echo "Starting Formatting Partition"

 #Informative messages
echo "Creating filesystems..."
echo "WARNING: Make sure you selected the correct partitions!"

# Create filesystems (use confirm_and_run for safety)
echo "Create filesystems .................!"
confirm_and_run "mkfs.fat -F32 -n \"EFISYSTEM\" \"/dev/$EFI_PARTITION\""
confirm_and_run "mkswap \"/dev/$SWAP_PARTITION\""
swapon "/dev/$SWAP_PARTITION"
confirm_and_run "mkfs.ext4 -L  \"ROOT\" \"/dev/$ROOT_PARTITION\""
echo "Successfly Formatted Partition !!!!"

# ==========================================================================
#               [END:: Partition]
# ==========================================================================

# ==========================================================================
#               [Start:: Mounting]
# ==========================================================================

# Mount target directories

echo "start mounting  into root partition...."

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
echo "copy arch-chroot scripts"
curl https://raw.githubusercontent.com/xconfcode/scritp2/main/s2.sh -o /mnt/s2.sh && chmod +x  /mnt/s2.sh














