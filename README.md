# nixos

Basic configuration and different test files 

To fix Hyprland simply needed to blacklist Nouveau module from kernel initilization. Gonna tro to see if disabling Gnome works or if its still needs to have another DE to open from occasionally.

Python environment was a little bit wierd to setup. I wasnt able to add some packages using nix's python packaging but instead added uv into the shell which I thin used to add different packages that arent part of the base nixpkgs list.
