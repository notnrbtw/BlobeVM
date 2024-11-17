git clone https://github.com/coder0-code/BlobeVM
cd BlobeVM
pip install textual
sleep 2
python3 installer.py
docker build -t blobevm . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir Save
cp -r BlobeVM/root/config/* Save

json_file="BlobeVM/options.json"
if jq ".enablekvm" "$json_file" | grep -q true; then
    docker run -d -e PUID=1000 -e PGID=1000 --device=/dev/kvm:/dev/kvm --device /dev/gpu:/dev/gpu --device /dev/dri:/dev/dri--security-opt seccomp=unconfined -e TZ=Europe/Stockholm -e SUBFOLDER=/  -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped blobevm
else
    docker run -d -e PUID=1000 -e PGID=1000 --device=/dev/kvm:/dev/kvm --device /dev/gpu:/dev/gpu --device /dev/dri:/dev/dri--security-opt seccomp=unconfined -e TZ=Europe/Stockholm -e SUBFOLDER=/  -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped blobevm
fi
clear
echo "BLOBEVM WAS INSTALLED SUCCESSFULLY! Check Port Tab"
