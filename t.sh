#!/usr/bin/env bash
clear
echo -e "\033[32m"  # Start green text

# ==================================================================================

# [[ START :: header]]

# ==================================================================================




header6="
====================================================================================================================================================

[[ 6. INSTALL-KERNAL-BASE-PACKAGES ]] 

====================================================================================================================================================
"


# ==================================================================================

# [[ END :: header]]

# ==================================================================================

# ==========================================================================
# [[ 6. INSTALL-KERNAL-BASE-PACKAGES ]] 
# ==========================================================================
clear
echo -e "\033[32m"  # Start green text
echo "$header6" 

echo -e "\nInstalling Base system into Linux kernal ...\n"
echo -e "\nInstalling Arch Linux base...\n"

pacstrap -K /mnt base linux linux-firmware sudo nano

 echo -e "\033[32m"  # Start green text
echo "Installed successsfly  Base system into Linux kernal !!!!"
time sleep 3






