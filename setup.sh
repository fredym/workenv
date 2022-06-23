#!/bin/bash


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
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# Install brew formulae
log "Installing brew formulae..."
grep -v '^#' $HOME/own/workenv/setup.d/brew_formulae | xargs brew install --force-bottle


# Update outdated brew formulae
log "Updating outdated brew formulae..."
brew upgrade;


# Install brew casks
log "Installing brew casks..."
grep -v '^#' $HOME/own/workenv/setup.d/brew_casks | xargs brew install --cask


# Cleanup brew cache
log "Cleaning up brew cache..."
brew cleanup;


# Install package managers
#log "Installing package managers..."
#rscript -e 'install.packages("packrat",repos="https://cran.rstudio.com")'


# Symlink and download useful tools and files
log "Symlinking useful tools and files..."
ln -sf /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport


# Install config files
log "Installing config files..."


# Create symlink in homedir to config directory
# This helps having short paths
ln -sfh $HOME/own/workenv/config $HOME/.dot


# Replace config files in homedir with symlinks to .dot config files
ln -sf .dot/alias $HOME/.alias
ln -sf .dot/bashrc $HOME/.bashrc
ln -sf .dot/bash_profile $HOME/.bash_profile
ln -sf .dot/gitconfig $HOME/.gitconfig
ln -sf .dot/vimrc $HOME/.vimrc
ln -sf ../.dot/atom_config.cson $HOME/.atom/config.cson


# macOS configuration
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
