#!/bin/sh


# Stop script if Ctrl+C is hit
trap exit SIGHUP SIGINT SIGTERM


# Format output
log () {
  b=$(tput bold)
  n=$(tput sgr0)

  echo "$b$1$n"
}


# Install XCode command line tools
xcode-select --install &>/dev/null

if [ $? -eq 0 ]; then
  log "XCode command line tools will be installed in a separate window"
  read -p "Press RETURN when the installation is complete..."
else
  log "XCode command line tools already installed"
fi


# Create the own directory
mkdir own; cd own;


# Clone the workenv repo
git clone https://github.com/fredym/workenv.git
git -C workenv remote set-url origin git@github.com:fredym/workenv.git


# Set hostname
log "Current computer name is $HOSTNAME"
read -p "Type the computer name you want to set: " NEW_HOSTNAME
if [ "$HOSTNAME" != "$NEW_HOSTNAME" ]; then
  log "Changing computer name to $NEW_HOSTNAME"

  sudo scutil --set HostName $NEW_HOSTNAME
  sudo scutil --set LocalHostName $NEW_HOSTNAME
  sudo scutil --set ComputerName $NEW_HOSTNAME

  # Reboot required to apply system config changes
  log "A system reboot is required"
  log "Execute setup from own/workenv/ to continue after reboot"
  read -p "Press RETURN to continue..."
  sudo reboot
else
  log "Computer name is already $NEW_HOSTNAME"
  cd workenv
  ./setup
fi
