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
nix-channel --add https://nixos.org/channels/nixos-21.05 nixpkgs
```

### III) Install home-manager

First add the nix channel

```
nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager
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

a) On a non-NixOS system

```
cd Projects/
git clone git@github.com:gbogard/dotfiles.git

# Create a symlink from a machine's folder folder to the .config folder
ln -s ~/Projects/dotfiles/machines/work-mac/home.nix ~/.config/nixpkgs 

# Switch to the new config
home-manager switch
```

b) On a NixOS system

```
cd Projects/
git clone git@github.com:gbogard/dotfiles.git

# Rebuild the system using the machine's configuration instead of /etc/nixos
nixos-rebuild switch -I nixos-config=/home/guillaume/Projects/nix-config/machines/nixos-workstation/configuration.nix
```
