# NixOS Personal Configuration
This configuration is inspired by various others, and was progressively modified as time went by.
It aims to be modular and sharable in nature while remaining easy enough to edit.
This configuration is technically *impure*, as it uses some data external to the config itself (i.e. information specific to you) for better usability. This data should **not** be placed inside the git reposotiry. Instead, use the template found in `./data/miscellaneous/settings_template.nix` and place the completed file in `/etc/nixos/`.
Use the `switch` alias to rebuild the system.
