# Nix personal environment

- [Darwin instructions](#darwin)
- [NixOS instructions](#nixos)

## Installation

### Darwin

#### I) Install Nix

##### Single user

```
curl -L https://nixos.org/nix/install | sh
```

##### Multi-user

```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

#### II) Add the stable nix channel

```
nix-channel --add https://nixos.org/channels/nixos-21.05 nixpkgs
```

#### III) Install nix-darwin

TODO

#### IV) Use the configuration

```
mkdir ~/Projects
cd ~/Projects/
git clone git@github.com:gbogard/nix-config.git

# Switch to the new config
darwin-rebuild switch -I darwin-config=$HOME/Projects/nix-config/machines/personal-mac/darwin-configuration.nix
```


### NixOS

```
cd Projects/
git clone git@github.com:gbogard/dotfiles.git

# Rebuild the system using the machine's configuration instead of /etc/nixos
nixos-rebuild switch -I nixos-config=/home/guillaume/Projects/nix-config/machines/nixos-workstation/configuration.nix
```

