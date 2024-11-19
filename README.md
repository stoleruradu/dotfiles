# Managing dotfiles using Nix home-manager

## Prerequisite

Install Nix 2.4 or later

Install the home manager and activate

```zsh
nix run home-manager/master -- init --switch .
```

## Usage

Updating the package lock

```zsh
nix flake update
```

Activating changes

```zsh
home-manager switch --flake .

```


