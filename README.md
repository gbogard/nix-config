# Nix personal environment

## Installation

### I) Install Nix

#### Single user

```
curl -L https://nixos.org/nix/install | sh
```

#### Multi-user

```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### II) Add the stable nix channel

```
nix-channel --add https://nixos.org/channels/nixos-20.09 nixpkgs
```

### III) Install home-manager

First add the nix channel

```
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
nix-channel --update
```

Then add this to the current shell

```
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
```

Finally, install home-manager

```
nix-shell '<home-manager>' -A install
```

### IV) Use the configuration

```
cd Projects/
git clone git@github.com:gbogard/dotfiles.git

# Generate the details for the current computer
chmod +x Projects/dotfiles/generate-machine.sh
./Projects/dotfiles/generate-machine.sh

# Create a symlink from the dotfiles folder to the .config folder
ln -s ~/Projects/dotfiles/.config/nixpkgs ~/.config 

# Switch to the new config
home-manager switch
```