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
