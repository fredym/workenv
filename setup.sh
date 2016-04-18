#!/bin/bash

# Script parameters
NEW_HOSTNAME=aleph


# Stop script if Ctrl+C is hit
trap exit SIGHUP SIGINT SIGTERM


# Format output
log () {
  b=$(tput bold)
  n=$(tput sgr0)

  echo "$b$1$n"
}


# Set hostname
if [ "$HOSTNAME" != "$NEW_HOSTNAME" ]; then
  log "Changing computer name to $NEW_HOSTNAME"

  sudo scutil --set HostName $NEW_HOSTNAME
  sudo scutil --set LocalHostName $NEW_HOSTNAME
  sudo scutil --set ComputerName $NEW_HOSTNAME

  # Reboot required to apply system config changes
  log "A system reboot is required"
  read -p "Press RETURN to continue..."
  sudo reboot
else
  log "Computer name already is $NEW_HOSTNAME"
fi


# Install XCode command line tools
xcode-select --install &>/dev/null

if [ $? -eq 0 ]; then
  log "XCode command line tools will be installed in a separate window"
  read -p "Press RETURN when the installation is complete..."
else
  log "XCode command line tools already installed"
fi


# Install brew
brew --version &>/dev/null

if [ $? -eq 0 ]; then
  log "brew already installed. Updating..."
  brew update
else
  log "Installing brew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# Install brew formulae
log "Installing brew formulae..."
brew install --force-bottle \
  aircrack-ng \
  awscli \
  bash-completion \
  docker \
  docker-compose \
  docker-machine \
  git \
  gnupg \
  lynx \
  mdbtools \
  python \
  homebrew/science/r \
  ruby \
  tree \
  watch \


# Update outdated brew formulae
log "Updating outdated brew formulae..."
brew upgrade;


# Install brew casks
log "Installing brew casks..."
brew cask install \
  android-file-transfer \
  atom \
  chitchat \
  diffmerge \
  dropbox \
  evernote \
  gimp \
  keka \
  progressive-downloader \
  rstudio \
  sequel-pro \
  skype \
  slack \
  spectacle \
  teamviewer \
  ticktick \
  trello-x \
  vagrant \
  virtualbox \


# Cleanup brew cache
log "Cleaning up brew cache..."
brew cleanup;
brew cask cleanup;


# Install atom packages
log "Installing atom packages..."
apm install \
  autoclose-html \
  language-docker \
  language-haml \
  language-r \
  last-cursor-position \
  sublime-style-column-selection \


# Install R packages
log "Installing R packages..."
Rscript install_r_packages.R


# Symlink useful tools and files
log "Symlinking useful tools and files..."
ln -sf /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
ln -sf iTunes/iTunes\ Media/Automatically\ Add\ to\ iTunes.localized ~/Music/autoadd


# Make tools executable
log "Making tools executable..."
chmod -R +x tools


# Install config files
log "Installing config files..."


# Create symlink in homedir to config directory
# This helps having short paths
ln -sfh $(pwd)/config ~/.dot


# Replace config files in homedir with symlinks to .dot config files
cd
ln -sf .dot/alias .alias
ln -sf .dot/bashrc .bashrc
ln -sf .dot/bash_profile .bash_profile
ln -sf .dot/gitconfig .gitconfig
ln -sf .dot/vimrc .vimrc
ln -sf ../.dot/atom_config.cson .atom/config.cson


# SSH configuration
if ! [ -e .ssh ]; then
  mkdir .ssh
  chmod 700 .ssh
fi
ln -sf ../.dot/ssh_config .ssh/config
ln -sf ../.dot/ssh_known_hosts .ssh/known_hosts
chmod 600 .ssh/*


# Overwrite config files not suitable to be symlinked
cp .dot/com.apple.Terminal.plist Library/Preferences/


# List brew casks to cleanup manually
CASKS_MANUAL_CLEANUP=$(ls -l /opt/homebrew-cask/Caskroom/ | awk '{if ($2 > 4) print $9}')
if [ -n "$(echo $CASKS_MANUAL_CLEANUP | tr -d '\n')" ]; then
  log "These Casks need manual cleanup: "
  echo $CASKS_MANUAL_CLEANUP
fi
