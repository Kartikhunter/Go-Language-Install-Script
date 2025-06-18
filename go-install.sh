#!/bin/bash

# Color codes
GREEN='\033[1;32m'
NC='\033[0m' # No Color
BOLD='\033[1m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'

# Banner
echo -e "${CYAN}"
echo "+---------------------------------------------+"
echo "|               GOLANG INSTALLER              |"
echo "|            Script by Kartik Garg            |"
echo "|    Automatically install latest Golang      |"
echo "+---------------------------------------------+"
echo -e "${NC}"
sleep 1

# Find latest version
echo -e "${YELLOW}[+]${NC} Fetching latest Golang version..."
LATEST_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n1)
LATEST_TAR="${LATEST_VERSION}.linux-amd64.tar.gz"
sleep 1

# Remove previous Go
echo -e "${YELLOW}[+]${NC} Removing previous Go installation..."
sudo apt-get remove -y golang-go > /dev/null 2>&1
sudo apt-get remove --auto-remove -y golang-go > /dev/null 2>&1
sudo rm -rvf /usr/local/go > /dev/null 2>&1
sleep 1

# Download latest Go
echo -e "${YELLOW}[+]${NC} Downloading $LATEST_VERSION..."
wget "https://go.dev/dl/${LATEST_TAR}" -q
sleep 1

# Extract and install
echo -e "${YELLOW}[+]${NC} Extracting and installing $LATEST_VERSION..."
tar -xvf "${LATEST_TAR}" > /dev/null
sudo mv go /usr/local
rm -rf "${LATEST_TAR}"
sleep 1

# Set environment variables
echo -e "${YELLOW}[+]${NC} Setting up environment variables..."
echo "export GOROOT=/usr/local/go" >> ~/.profile
echo "export GOPATH=\$HOME/go" >> ~/.profile
echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.profile
source ~/.profile
sleep 1

# Verify Installation
echo -e "${YELLOW}[+]${NC} Verifying installation...${NC}"
sleep 1
INSTALLED_VERSION=$(go version 2>/dev/null)

# Done
if [[ $INSTALLED_VERSION == *"$LATEST_VERSION"* ]]; then
        echo -e "${YELLOW}[+]${NC} $LATEST_VERSION has been successfully installed!${NC}"
        echo -e "${YELLOW}[+]${NC} Run '${GREEN}go version${GREEN}' ${NC}to verify it anytime.${NC}"
else
  echo -e "${RED}[+] Something went wrong. Please try again.${NC}"
fi
