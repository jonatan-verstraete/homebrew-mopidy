# Mopidy-3.4.2 - hacky fix for MacOs
This fork aims to bridge gap while waiting for a stable 4.x release.

Issue: Current Mopidy code expecting legacy packaging behavior vs modern Homebrew Python constraints.
Solution: manually resolving issues.


> ** WARNING**: this will possibly break brew's python 3.12. If you are relying on this python version for other projects, reconsider continuing if you don't know what you're doing (ask Claude).


## Manual fix
First off, simply install:
```bash
brew tap jonatan-verstraete/homebrew-mopidy https://github.com/jonatan-verstraete/homebrew-mopidy

brew install jonatan-verstraete/mopidy/mopidy --build-from-source
```

Then run the [fix.sh](./fix.sh) to (hopefully) resolve import issues.
```sh
bash fix.sh
```

> Ask GPT if you are unsure what this code does.