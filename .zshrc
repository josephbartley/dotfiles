# append this to ~/.zshrc after installing and setting up zsh and oh-my-zsh
alias codium="FLATPAK_ENABLE_SDK_EXT=golang,dotnet7,rust-nightly flatpak run com.vscodium.codium"
alias c="clear"
alias gopher="toolbox enter gopher"
alias rust-bucket="toolbox enter rust-bucket"
alias dotnet-box="toolbox enter dotnet-box"
alias upgrade="sudo rpm-ostree upgrade && sudo flatpak upgrade -y && toolbox run --container gopher sudo dnf upgrade -y && toolbox run --container rust-bucket sudo>

export PATH=$PATH:$HOME/go/bin
