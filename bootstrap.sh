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
workenv_path="$HOME/fredym/workenv"


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
