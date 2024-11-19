# GNU stow

```bash
brew install stow
```

Run stow

```bash
stow --verbose .
```

Sync new changes

```bash
stow --verbose --adopt -R .

```

More infor: `man stow`

# Migrating to Nix home-manager

## Prerequisite
    Install Nix 2.4 or later

Install the home manager and activate

```zsh
nix run home-manager/master -- init --switch .
```

Updating the package lock

```zsh
nix flake update
```

Activating changes

```zsh
home-manager switch --flake .

```


