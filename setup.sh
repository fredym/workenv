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
grep -v '^#' $HOME/own/workenv/setup.d/brew_formulae | xargs brew install --force-bottle


# Update outdated brew formulae
log "Updating outdated brew formulae..."
brew upgrade;


# Install brew casks
log "Installing brew casks..."
grep -v '^#' $HOME/own/workenv/setup.d/brew_casks | xargs brew cask install


# Cleanup brew cache
log "Cleaning up brew cache..."
brew cleanup;


# Install atom packages
log "Installing atom packages..."
grep -v '^#' $HOME/own/workenv/setup.d/atom_packages | xargs apm install


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


# Overwrite config files not suitable to be symlinked
cp $HOME/.dot/com.apple.Terminal.plist $HOME/Library/Preferences/


# Overwrite some macOS environment default settings
defaults write com.apple.screencapture location $HOME/Downloads
