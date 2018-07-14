#!/bin/sh


# Stop script if Ctrl+C is hit
trap exit SIGHUP SIGINT SIGTERM


# Format output
log () {
  b=$(tput bold)
  n=$(tput sgr0)

  echo "$b$1$n"
}


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
xargs brew install --force-bottle < setup.d/brew_formulae


# Update outdated brew formulae
log "Updating outdated brew formulae..."
brew upgrade;


# Install brew casks
log "Installing brew casks..."
xargs brew cask install < setup.d/brew_casks


# Cleanup brew cache
log "Cleaning up brew cache..."
brew cleanup;
brew cask cleanup;


# Install atom packages
log "Installing atom packages..."
xargs apm install < setup.d/atom_packages


# Install package managers
log "Installing package managers..."
rscript -e 'install.packages("packrat",repos="https://cran.rstudio.com")'


# Symlink and download useful tools and files
log "Symlinking useful tools and files..."
ln -sf /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport


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


# Overwrite config files not suitable to be symlinked
cp .dot/com.apple.Terminal.plist Library/Preferences/


# Overwrite some macOS environment default settings
defaults write com.apple.screencapture location ~/Downloads