# Mopidy-3.4.2 - hacky fix for MacOs
This fork aims to bridge gap while waiting for a stable 4.x release.


**Problem**:
Current Mopidy code expecting legacy packaging behavior vs Homebrew Python 3.11 constraints.

## Basic install
```bash
brew tap jonatan-verstraete/homebrew-mopidy https://github.com/jonatan-verstraete/homebrew-mopidy

brew install jonatan-verstraete/mopidy/mopidy --build-from-source
```

## Fix
> ⚠️ This modifies Homebrew’s Python 3.11 environment.
If you rely on Brew’s python@3.11 for other projects, proceed carefully.
The shim may affect other tooling that depends on real pkg_resources.

```sh
# allows us to install external packages in the venv
/opt/homebrew/bin/python3.11 -m pip config set global.break-system-packages true
/opt/homebrew/bin/python3.11 -m pip install pykka PyGObject
```

Finally run:
```sh
mopidy
```
