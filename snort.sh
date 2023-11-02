#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $* (tip: you can rerun the previous terminal command by entering: sudo !!)"
    exit 1
fi

echo "==> Backing up sources list for kali"
mv /etc/apt/sources.list /etc/apt/sources.list.bak
echo "==> Removing cached updates"
find /var/lib/apt/lists -type f -exec rm {} \;
echo "==> Downloading required ubuntu sources list..."
wget https://raw.githubusercontent.com/GlenMerlin/snort-kali-installer/main/sources.list -O /etc/apt/sources.list
echo "==> Installing ubuntu GPG keys"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C
echo "==> Installing snort!"
sudo apt update && sudo apt install snort -y
echo "==> Cleaning up"
find /var/lib/apt/lists -type f -exec rm {} \;
mv /etc/apt/sources.list /etc/apt/ubuntu_sources.list
echo "==> Restoring Kali sources list"
mv /etc/apt/sources.list.bak /etc/apt/sources.list
echo "==> Checking for Kali updates..."
sudo apt update && sudo apt upgrade -y
echo "==> Snort installed successfull!"
