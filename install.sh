#!/bin/bash

# THIS FILE IS INTENDED TO BE RAN ON A NEW FEDORA INSTALL YMMV
# this file should mostly work but needs to be updated for toolbox implementation
# TODO: add option for toolbox-ifying
# TODO: add option for certain types of applications (games, art, etc.)
# TODO: update how we handle extension selection

setup_flathub()
{
	sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

install_basic_flatpaks()
{
	# install flatpaks 
	sudo flatpak install flathub com.github.tchx84.Flatseal -y
	sudo flatpak install flathub com.brave.Browser -y
	sudo flatpak install flathub com.bitwarden.desktop -y
	sudo flatpak install flathub com.discordapp.Discord -y
	sudo flatpak install flathub org.signal.Signal -y
	sudo flatpak install flathub org.godotengine.Godot -y
	
	## entertainment
	sudo flatpak install flathub com.valvesoftware.Steam -y
	sudo flatpak install flathub com.spotify.Client -y
	sudo flatpak install flathub io.itch.itch -y
	sudo flatpak install flathub net.lutris.Lutris -y
	sudo flatpak install flathub com.mojang.Minecraft -y

	## art
	sudo flatpak install flathub org.blender.Blender -y
	sudo flatpak install flathub org.gimp.GIMP -y 
	sudo flatpak install flathub org.inkscape.Inkscape -y
}

install_codium()
{
	sudo flatpak install flathub com.vscodium.codium -y
	mkdir ~/.config/VSCodium
	touch ~/.config/VSCodium/product.json
	echo '{
	  "extensionsGallery": {
	    "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
	    "itemUrl": "https://marketplace.visualstudio.com/items",
	    "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
	    "controlUrl": ""
	  }
	}' >> ~/.config/VSCodium/product.json

	mkdir ~/.var/app/com.vscodium.codium
	mkdir ~/.var/app/com.vscodium.codium/config
	mkdir ~/.var/app/com.vscodium.codium/config/VSCodium
	mkdir ~/.var/app/com.vscodium.codium/config/VSCodium/User
	touch ~/.var/app/com.vscodium.codium/config/VSCodium/User/settings.json
	cat "./codium/settings.json" > ~/.var/app/com.vscodium.codium/config/VSCodium/User/settings.json
	flatpak run com.vscodium.codium --install-extension ahmadawais.shades-of-purple
	flatpak run com.vscodium.codium --install-extension ms-dotnettools.vscode-dotnet-runtime
	flatpak run com.vscodium.codium --install-extension ms-dotnettools.csharp
	flatpak run com.vscodium.codium --install-extension dbaeumer.vscode-eslint
	flatpak run com.vscodium.codium --install-extension golang.go
	flatpak run com.vscodium.codium --install-extension Orta.vscode-jest
	flatpak run com.vscodium.codium --install-extension ritwickdey.LiveServer
	flatpak run com.vscodium.codium --install-extension esbenp.prettier-vscode
}

install_git_stuff()
{
	sudo dnf install git -y
	git config --global --add --bool push.autoSetupRemote true
	sudo dnf install gh -y
}

install_nodejs()
{
	sudo dnf install nodejs -y
}


install_dotnet()
{
	sudo dnf install dotnet-sdk-7.0 -y
	sudo flatpak install org.freedesktop.Sdk.Extension.dotnet7 -y
}

install_go()
{
	sudo dnf install golang -y 
	mkdir -p $HOME/go
	sudo flatpak install org.freedesktop.Sdk.Extension.golang -y 
	echo 'export GOPATH=$HOME/go' >> $HOME/.zshrc
}

add_custom_aliases()
{
	echo 'alias codium="FLATPAK_ENABLE_SDK_EXT=golang,dotnet7 flatpak run com.vscodium.codium"' >> $HOME/.zshrc
	echo 'alias c="clear"' >> $HOME/.zshrc
	source $HOME/.zshrc
}

# upgrade existing dependencies
sudo dnf upgrade -y 
sudo flatpak upgrade -y

# setup shell
sudo dnf install zsh -y
export RUNZSH='no'
sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
usermod -s $(which zsh) $USERNAME
add_custom_aliases

setup_flathub
install_basic_flatpaks
install_codium
install_git_stuff
install_dotnet
install_go

zsh -c -i "sudo dnf install neofetch -y && neofetch"
