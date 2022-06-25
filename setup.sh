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
grep -v '^#' "$workenv_path"/setup.d/brew_packages | xargs brew install --force-bottle


# Update outdated brew formulae
log "Updating outdated brew formulae..."
brew upgrade;


# Cleanup brew cache
log "Cleaning up brew cache..."
brew cleanup;
