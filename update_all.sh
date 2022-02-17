# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "${GREEN}[ * ]${NC} System update script"
# Check if sudo
if [ "$EUID" -ne 0 ]
  then echo "${RED}[ * ]${NC} Please run as root"
  exit
fi
echo 
echo "${YELLOW}[ * ]${NC} Updating system..."
softwareupdate -l 1>/dev/null
echo
# Check if homebrew is installed and install if not

if [ ! -d /opt/homebrew/Cellar ]; then
    echo "${RED}[ * ]${NC} Homebrew is not installed"
    echo "${YELLOW}[ * ]${NC} Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 1> /dev/null
    echo "${GREEN}[ * ]${NC} Homebrew installed"
else
    echo "${GREEN}[ * ]${NC} Homebrew is installed"
fi
echo
echo "${YELLOW}[ * ]${NC} Updating homebrew packages..."
brew update 1>/dev/null && brew upgrade 1>/dev/null
echo
echo "${YELLOW}[ * ]${NC} Cleaning up homebrew..."
brew cleanup
echo
echo "${YELLOW}[ * ]${NC} Removing homebrew not needed packages..."
brew autoremove 1>/dev/null
echo

# check if /Users/gabrielvr/dev/dsstore-deleter/main.py exists

echo "${YELLOW}[ * ]${NC} Removing .DS_Store files..."
if [ ! -f /Users/gabrielvr/dev/dsstore-deleter/main.py ]; then
    echo "${RED}[ * ]${NC} dsstore-deleter.py dosent exist"
    echo
    echo "Get it from https://github.com/GabrielCrackPro/Setup/blob/main/Scripts/delete-dsstore.py"
else
python /Users/gabrielvr/dev/dsstore-deleter/main.py / 1>/dev/null
fi
echo
echo "${YELLOW}[ * ]${NC} Clearing DNS cache..."
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
echo "${GREEN}[ * ]${NC} DNS cache cleared"
echo
# Check if node is installed and install if not

if [ ! -f /opt/homebrew/bin/node ]; then
    echo "${RED}[ * ]${NC} Node is not installed"
    echo "${YELLOW}[ * ]${NC} Installing node..."
    brew install node 1>/dev/null
else
    echo "${GREEN}[ * ]${NC} Node is installed"
fi
echo
echo "${YELLOW}[ * ]${NC} Updating node packages..."
npm update -g 1>/dev/null
echo "${GREEN}[ * ]${NC} Node packages updated"
echo
echo "${GREEN}[ * ]${NC} Script completed"
echo