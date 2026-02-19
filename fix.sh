# Fixed Homebrew Python 3.12 site-packages path on macOS

# allows us to install external packages in the venv
/opt/homebrew/bin/python3.12 -m pip config set global.break-system-packages true

# install missing deps
/opt/homebrew/bin/python3.12 -m pip install pykka PyGObject


# Create 'shim' for "pkg_resources"

PKG_FILE="/opt/homebrew/lib/python3.12/site-packages/pkg_resources.py"

# Write the shim
cat > "$PKG_FILE" <<'EOF'
# Minimal pkg_resources shim for Mopidy 3.4.2 on Python 3.12
from importlib.metadata import entry_points, version

class DummyDist:
    def __init__(self, name):
        self.project_name = name
        self.version = version(name)

def iter_entry_points(group):
    return entry_points(group=group)

def get_distribution(name):
    return DummyDist(name)
EOF

echo "Try running: mopidy"