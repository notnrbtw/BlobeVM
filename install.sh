git clone https://github.com/coder0-code/BlobeVM
cd BlobeVM

# Install Python dependency
pip install textual

# Pause briefly to ensure installation completes
sleep 2

# Run the Python installer
python3 installer.py

# Build the Docker image without cache
docker build -t blobevm . --no-cache

cd ..

# Update system and install jq
sudo apt update
sudo apt install -y jq

# Create a directory for saving configuration
mkdir Save
cp -r BlobeVM/root/config/* Save

# Path to the options.json file
json_file="BlobeVM/options.json"

# Determine whether to enable KVM
if jq ".enablekvm" "$json_file" | grep -q true; then
    docker run -d \
        -e PUID=1000 \
        -e PGID=1000 \
        --device=/dev/kvm:/dev/kvm \
        --device=/dev/dri:/dev/dri \
        --security-opt seccomp=unconfined \
        -e TZ=Etc/UTC \
        -e SUBFOLDER=/ \
        -p 3000:3000 \
        --shm-size="2gb" \
        -v "$(pwd)/Save:/config" \
        --restart unless-stopped \
        blobevm
else
    docker run -d \
        -e PUID=1000 \
        -e PGID=1000 \
        --device=/dev/kvm:/dev/kvm \
        --device=/dev/dri:/dev/dri \
        --security-opt seccomp=unconfined \
        -e TZ=Etc/UTC \
        -e SUBFOLDER=/ \
        -p 3000:3000 \
        --shm-size="2gb" \
        -v "$(pwd)/Save:/config" \
        --restart unless-stopped \
        blobevm
fi

# Clear the terminal and display success message
clear
echo "BLOBEVM WAS INSTALLED SUCCESSFULLY! Check Port Tab"
