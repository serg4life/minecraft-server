#!/bin/bash

echo "Installing Minecraft server files"
echo "Downloading Oficial Minecraft Vanilla server"
wget https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar
echo "Done."

echo "Downloading Liberica JDK 21.0.6"
wget https://download.bell-sw.com/java/21.0.6+10/bellsoft-jdk21.0.6+10-linux-aarch64.deb
echo "Done."

echo "Installing Liberica JDK 21.0.6"
sudo apt install ./sudo apt install ./bellsoft-jdk21.0.6+10-linux-aarch64.deb
rm ./bellsoft-jdk21.0.6+10-linux-aarch64.deb
echo "Done."

echo "Installing screen from the repositories"
sudo apt install screen
echo "Done."

echo "Configuring the service"
cp ./services/minecraft-server.service /lib/systemd/system/
systemctl enable minecraft-server.service
systemctl start minecraft-server.service
systemctl status minecraft-server.sevice
echo "Done."

chmod a+x ./mcstart
sudo install ./mcstart /usr/local/bin
echo "Done."
