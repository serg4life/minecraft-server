#!/bin/bash

# Cargar configuración desde el archivo
source parameters.conf

# Crear el usuario y grupo si no existen
if ! id "$USER_NAME" &>/dev/null; then
    echo "Creando usuario y grupo $USER_NAME..."
    sudo groupadd -f "$GROUP_NAME"
    sudo useradd -r -g "$GROUP_NAME" -d "$WORKING_DIR" "$USER_NAME"
fi

# Crear el directorio de trabajo si no existe
sudo mkdir -p "$WORKING_DIR"
sudo chown -R "$USER_NAME":"$GROUP_NAME" "$WORKING_DIR"
sudo cp minecraft_server.jar "$WORKING_DIR"

# Generar el archivo del servicio
echo "Creando servicio systemd..."
sudo tee /etc/systemd/system/minecraft.service > /dev/null <<EOF
[Unit]
Description=Minecraft Vanilla Server
After=network.target

[Service]
User=$USER_NAME
Group=$GROUP_NAME
Restart=on-abort
WorkingDirectory=$WORKING_DIR
ExecStart=/usr/bin/screen -DmS minecraft-screen /usr/bin/java $JAVA_OPTIONS -jar server.jar nogui

[Install]
WantedBy=multi-user.target
EOF

# Recargar systemd, habilitar y arrancar el servicio
sudo systemctl daemon-reload
sudo systemctl enable minecraft
sudo systemctl start minecraft

echo "Instalacion completada. El servidor de Minecraft esta ejecutandose."
