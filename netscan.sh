# Author: GabrielCrackPro
#
# Date: 29/08/2021
#

read -p '[ ? ] IP Address: ' ip
read -p '[ ? ] Save results as: ' file
echo "[ i ] Results will be saved as $file.txt"
echo "[ i ] Scaning $ip..."
nmap $ip -v0 -sV -n -oN $file.txt
echo [ ✔ ] Scan complete. Showing results...
sleep 3
cat "$file.txt"
exit 0
