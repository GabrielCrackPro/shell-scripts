#!/bin/bash
echo "System update script"
echo "===================="
echo
echo "Updating system..."
softwareupdate -l
echo
echo "Updating homebrew..."
brew update
echo
echo "Upgrading homebrew packages..."
brew upgrade
echo
echo "Cleaning homebrew cache..."
brew cleanup --prune=all
brew autoremove
echo
echo "System updated succesfully"
