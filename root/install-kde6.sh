#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Add Kubuntu and KDE Neon repositories for noble version
echo "Adding Kubuntu and KDE Neon repositories..."

# Add the Kubuntu repository
sudo add-apt-repository ppa:kubuntu-ppa/backports -y

# Add the KDE Neon repository (replace with the correct PPA if needed)
echo "deb https://archive.neon.kde.org/user/ noble main" | sudo tee /etc/apt/sources.list.d/kde-neon.list

# Import the repository GPG keys
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32

# Create a preferences file for pinning
echo "Creating pinning preferences..."
sudo tee /etc/apt/preferences.d/kde-neon <<EOF
Package: *
Pin: release o=KDE
Pin-Priority: 1001
EOF

# Update package lists
echo "Updating package lists..."
sudo apt update

# Perform full upgrade with dpkg force overwrite option
echo "Installing KDE version 6."
sudo apt full-upgrade -o Dpkg::Options::="--force-overwrite"

echo "Upgrade completed successfully."
