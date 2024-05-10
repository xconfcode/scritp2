#!/bin/bash

G_Pacman_pkg=(
    "pacman-contrib"
    "vim"
    "bluez"
    "bluez-utils"
    "neovim"
    "wget"
    "unzip"
    "alacritty" 
    "rofi" 
    "chromium" 
    "dunst" 
    "starship"
    "mpv" 
    "freerdp" 
    "thunar" 
    "mousepad"
    "noto-fonts" 
    "otf-font-awesome" 
    "ttf-fira-sans" 
    "ttf-fira-code" 
    "ttf-firacode-nerd" 
    "figlet" 
    "vlc" 
    "eza" 
    "python-pip" 
    "python-psutil" 
    "python-rich" 
    "python-click" 
    "pavucontrol" 
    "tumbler" 
    "blueman"
    "papirus-icon-theme"
    "polkit-gnome"
    "brightnessctl"
    "gum"
    "man-pages"
    "xdg-desktop-portal"
    "nm-connection-editor"
    "gvfs"
    "xdg-user-dirs"
    "networkmanager"
    "network-manager-applet"
    "fuse2"
    "gtk4"
    "libadwaita"
    "tree"
    "tmux"
    "htop"
    "cmatrix"
    );

    G_Yay_pkg=(
        "pfetch" 
        "bibata-cursor-theme" 
        "trizen"
        "pacseek"
        ) 

# Start Install General Packages  



# Prompt for Pacman package installation
read -p "Mr BUDOKHI ...  Would you like to install General packages with Pacman Package Manager? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    # Install packages using yay
    sudo pacman -S --needed "${G_Pacman_pkg[@]}" --noconfirm
else
    echo "Skipping package installation."
fi


# Prompt for Yay package installation
read -p "Mr BUDOKHI ...  Would you like to install  General Packages with Yay Package Manager? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    # Install packages using yay
    #echo   " yay -Svv --needed "${G_Yay_pkg[@]} " --noconfirm"
    yay -S --needed "${G_Yay_pkg[@]}" --noconfirm
else
    echo "Skipping package installation."
fi
    



Hypr_pacman_pkg=(
    "xdg-desktop-portal-hyprland" 
    "waybar" 
    "grim" 
    "slurp"
    "swayidle"
    "swappy"
    "cliphist"
        ); 

Hypr_yay_pkg=(
    "swww" 
    "swaylock-effects-git" 
    "wlogout"
);

Nvim_pacman_LanguageSupport=(
    "nodejs" 
    "npm"
    )


# Prompt for Pacman package installation
read -p "Mr BUDOKHI ...  Would you like to install Hypr Packages Requirment with Pacman Package Manager? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    # Install packages using pacman
    sudo pacman -S --needed "${Hypr_pacman_pkg[@]}" --noconfirm
else
    echo "Skipping package installation."
fi


# Prompt for Yay package installation
read -p "Mr BUDOKHI ...  Would you like to install  Hypr Packages Requirment with Yay Package Manager? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    # Install packages using yay
    #echo   " yay -Svv --needed "${G_Yay_pkg[@]} " --noconfirm"
    yay -S --needed "${Hypr_yay_pkg[@]}" --noconfirm
else
    echo "Skipping package installation."
fi

# [[Neovim-Lanaguage-Support]]::[[Pacman-Manager]]
read -p "Mr BUDOKHI ...  Install [[Language-support]] by Pacman-Manager...install..!! (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    # Install packages using pacman
    sudo pacman -S --needed "${Nvim_pacman_LanguageSupport[@]}" --noconfirm
else
    echo "Skipping package installation."
fi
