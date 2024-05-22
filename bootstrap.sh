#!/bin/bash


# Stop script if Ctrl+C is hit
trap exit SIGHUP SIGINT SIGTERM


# Format output
log () {
  b=$(tput bold)
  n=$(tput sgr0)

  echo "$b$1$n"
}


# Configure the script
workenv_path="$HOME/code/fredym/workenv"


# Set bash as the default shell
chsh -s /bin/bash
log "Default shell set to bash"


# Install XCode command line tools
xcode-select --install &>/dev/null

if [ $? -eq 0 ]; then
  log "Installation of XCode command line tools will start in a separate window"
  read -p "Press RETURN after installation is complete..."
else
  log "XCode command line tools already installed"
fi


# Setup the workenv directory
if [ ! -d "$workenv_path" ]; then
  log "Setting up the workenv directory"

  # Create the workenv directory
  mkdir -p "$workenv_path"

  # Clone the workenv repo
  git clone https://github.com/fredym/workenv.git "$workenv_path"
  git -C "$workenv_path" remote set-url origin git@github.com:fredym/workenv.git
else
  log "Workenv directory already setup"
fi


# Symlink and download useful tools and files
log "Symlinking useful tools and files..."
sudo mkdir -p /usr/local/bin
sudo ln -sf /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport


# Install config files
log "Installing config files..."


# Create symlink in homedir to config directory
# This helps having short paths
ln -sfh "$workenv_path"/config $HOME/.dot


# Replace config files in homedir with symlinks to .dot config files
ln -sf .dot/alias $HOME/.alias
ln -sf .dot/bashrc $HOME/.bashrc
ln -sf .dot/bash_profile $HOME/.bash_profile
ln -sf .dot/gitconfig $HOME/.gitconfig
ln -sf .dot/vimrc $HOME/.vimrc


# macOS configuration
log "Updating macOS defaults..."

defaults write com.apple.screencapture location $HOME/Downloads

defaults write com.apple.Dock autohide 1
defaults write com.apple.Dock magnification 1
defaults write com.apple.Dock show-recents 0

defaults write com.apple.AppleMultitouchMouse MouseButtonMode TwoButton
defaults write com.apple.AppleMultitouchMouse MouseOneFingerDoubleTapGesture 1

defaults write com.apple.AppleMultitouchTrackpad Clicking 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture 0


# Set hostname
log "Current hostname is $HOSTNAME"
read -p "Type the NEW hostname you want to set: " NEW_HOSTNAME
if [ "$HOSTNAME" != "$NEW_HOSTNAME" ]; then
  log "Changing hostname to $NEW_HOSTNAME"

  sudo scutil --set HostName $NEW_HOSTNAME
  sudo scutil --set LocalHostName $NEW_HOSTNAME
  sudo scutil --set ComputerName $NEW_HOSTNAME

  # Reboot required to apply system config changes
  log "A system reboot is required"
  read -p "Press RETURN to continue..."
  sudo reboot
else
  log "Hostname is $NEW_HOSTNAME already"
fi
