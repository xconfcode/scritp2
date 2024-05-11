#!/usr/bin/env bash
clear
echo -e "\033[32m"  # Start green text

cat <<EOF


██╗████████╗    ██████╗ ██████╗  ██████╗ 
██║╚══██╔══╝    ██╔══██╗██╔══██╗██╔═══██╗
██║   ██║       ██████╔╝██████╔╝██║   ██║
██║   ██║       ██╔═══╝ ██╔══██╗██║   ██║
██║   ██║       ██║     ██║  ██║╚██████╔╝
╚═╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝ ╚═════╝ 
                                                                                    
EOF


    G_Yay_pkg=(
        "pfetch" 
        "bibata-cursor-theme" 
        "trizen"
        "pacseek"
        "gdb" 
        "ninja" 
        "gcc" 
        "cmake" 
        "meson" 
        "libxcb" 
        "xcb-proto" 
        "xcb-util"
        "xcb-util-keysyms" 
        "libxfixes" 
        "libx11" 
        "libxcomposite" 
        "xorg-xinput" 
        "libxrender" 
        "pixman" 
        "wayland-protocols" 
        "cairo" 
        "pango" 
        "seatd" 
        "libxkbcommon" 
        "xcb-util-wm" 
        "xorg-xwayland" 
        "libinput" 
        "libliftoff" 
        "libdisplay-info" 
        "cpio" 
        "tomlplusplus" 
        "hyprlang" 
        "hyprcursor" 
        
        ) 


echo -e "\nHyperLand....\n"

read -rp "would you like install hyprland Dependencies for ArchLinux? (y/n): " choice

    if [[ $choice == "y" || $choice == "Y" ]]; then
       yay -S --needed "${G_Yay_pkg[@]}" --noconfirm

    else
          echo "Ok !! As you choosse skipe"
    fi





