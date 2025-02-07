#!/bin/bash
echo "Installing Minecraft server files"
chmod a+x ./mcstart
sudo install ./mcstart /usr/local/bin
echo "Done."
