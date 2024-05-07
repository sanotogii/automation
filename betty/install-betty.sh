#!/bin/bash
#the script must run with sudo
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with sudo."
    exit 1
fi

#update machine and install git
sudo apt update && sudo apt upgrade -y
sudo apt install git
git clone https://github.com/alx-tools/Betty.git

cd Betty || exit

sudo ./install.sh

touch betty

# Open betty using Vim
vim betty -c ":wq"

# Copy the provided script into "betty"
cat <<EOF > betty
#!/bin/bash
# Simply a wrapper script to keep you from having to use betty-style
# and betty-doc separately on every item.
# Originally by Tim Britton (@wintermanc3r), multiargument added by
# Larry Madeo (@hillmonkey)

BIN_PATH="/usr/local/bin"
BETTY_STYLE="betty-style"
BETTY_DOC="betty-doc"

if [ "\$#" = "0" ]; then
    echo "No arguments passed."
    exit 1
fi

for argument in "\$@" ; do
    echo -e "\n========== \$argument =========="
    \${BIN_PATH}/\${BETTY_STYLE} "\$argument"
    \${BIN_PATH}/\${BETTY_DOC} "\$argument"
done
EOF
# change permissions to apply to all users
chmod a+x betty

# Move the betty file into /bin/ directory
sudo mv betty /bin/
