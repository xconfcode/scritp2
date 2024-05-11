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





# ==================================================================================

# [[ END :: header]]

# ==================================================================================

clear 
echo -e "\033[32m"  # Start green text
echo "$header1"

echo -e "\nkey_activation for arch linux.....\n"

pacman-key --init
echo -e "\nupdating keys....\n"
pacman-key --populate

clear 
echo -e "\033[32m"  # Start green text
echo "$header1"
echo -e "================================================="
echo
echo -e "\nInstalling keys....\n"
echo
pacman -Syy archlinux-keyring --needed --noconfirm 


echo -e "================================================="
echo
echo -e "\033[32m"  # Start green text
echo -e "\nSuccessfully archlinux keyring attached....!!!!!\n"
echo
echo -e "\033[32m"  # Start green text
echo -e "================================================="

time sleep 3

