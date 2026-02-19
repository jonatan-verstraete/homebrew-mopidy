# Mopidy-3.4.2 - hacky fix for MacOs
This fork aims to bridge gap while waiting for a stable 4.x release.


**Problem**: Current Mopidy code expecting legacy packaging behavior vs Homebrew Python 3.12 constraints.

**Solution**: manually resolving issues.


> ⚠️ This modifies Homebrew’s Python 3.12 environment.
If you rely on Brew’s python@3.12 for other projects, proceed carefully.
The shim may affect other tooling that depends on real pkg_resources.



## Install
```bash
brew tap jonatan-verstraete/homebrew-mopidy https://github.com/jonatan-verstraete/homebrew-mopidy

brew install jonatan-verstraete/mopidy/mopidy --build-from-source
```

## Manual fix
Run the [fix.sh](./fix.sh) to resolve import issues. Note: needs a new session.

```sh
exec $SHELL
curl -s "https://raw.githubusercontent.com/jonatan-verstraete/homebrew-mopidy/refs/heads/main/fix.sh" | bash
echo "Try running: mopidy"
```

Finally run
```sh
mopidy
```

Enjoy
