# Mopidy-3.4.2 - hacky fix for MacOs
This fork aims to bridge gap while waiting for a stable 4.x release.


**Problem**:
Current Mopidy code expecting legacy packaging behavior vs Homebrew Python 3.11 constraints.

## Basic install
```bash
brew tap jonatan-verstraete/homebrew-mopidy https://github.com/jonatan-verstraete/homebrew-mopidy

brew install jonatan-verstraete/mopidy/mopidy --build-from-source
```


## The "fix"
> ⚠️ This modifies Homebrew’s Python 3.11 environment.
If you rely on Brew’s python@3.11 for other projects, proceed carefully.

```sh
/opt/homebrew/bin/python3.11 -m pip config set global.break-system-packages true
/opt/homebrew/bin/python3.11 -m pip install pykka PyGObject
```


Add these runtime paths:
```sh
export DYLD_LIBRARY_PATH=/opt/homebrew/lib
export GI_TYPELIB_PATH=/opt/homebrew/lib/girepository-1.0
```
or 
```sh
cat >> ~/.zshrc << EOF

# can be safely removed once using Mopidy v4
export DYLD_LIBRARY_PATH=/opt/homebrew/lib
export GI_TYPELIB_PATH=/opt/homebrew/lib/girepository-1.0
EOF
```


Finally run:
```sh
mopidy
```




### Full copy paste
```sh
brew tap jonatan-verstraete/homebrew-mopidy https://github.com/jonatan-verstraete/homebrew-mopidy
brew install jonatan-verstraete/mopidy/mopidy --build-from-source


/opt/homebrew/bin/python3.11 -m pip config set global.break-system-packages true
/opt/homebrew/bin/python3.11 -m pip install pykka PyGObject

cat >> ~/.zshrc << EOF

# can be safely removed once using Mopidy v4
export DYLD_LIBRARY_PATH=/opt/homebrew/lib
export GI_TYPELIB_PATH=/opt/homebrew/lib/girepository-1.0
EOF

source ~/.zshrc

exec $SHELL
mopidy
```