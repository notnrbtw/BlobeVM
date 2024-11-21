wget -P /workspaces/BlobeVM https://zed.dev/api/releases/stable/latest/zed-linux-x86_64.tar.gz

mkdir -p ~/.local
# extract zed to ~/.local/zed.app/
tar -xvf /workspaces/BlobeVM/zed-linux-x86_64.tar.gz -C ~/.local
# link the zed binary to ~/.local/bin (or another directory in your $PATH)
ln -sf ~/.local/zed.app/bin/zed ~/.local/bin/zed
