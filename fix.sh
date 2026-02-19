# Fixed Homebrew Python 3.12 site-packages path on macOS

# allows us to install external packages in the venv
/opt/homebrew/bin/python3.12 -m pip config set global.break-system-packages true

# install missing deps
/opt/homebrew/bin/python3.12 -m pip install pykka PyGObject


# Create 'shim' for "pkg_resources"

PKG_FILE="/opt/homebrew/lib/python3.12/site-packages/pkg_resources.py"


cat > "$PKG_FILE" <<'EOF'
# Minimal pkg_resources shim for Mopidy 3.4.2 on Python 3.12


from importlib.metadata import entry_points, version, PackageNotFoundError

class ResolutionError(Exception):
    pass
    
class DistributionNotFound(ResolutionError):
    pass

class VersionConflict(ResolutionError):
    pass


class _Dist:
    def __init__(self, name):
        self.project_name = name
        try:
            self.version = version(name)
        except PackageNotFoundError:
            raise DistributionNotFound(name)

class _EPWrapper:
    def __init__(self, ep):
        self._ep = ep
        self.name = ep.name
        self.module_name = ep.module
        self.attrs = [ep.attr] if ep.attr else []
        self.dist = _Dist(ep.dist.name)

    def load(self):
        return self._ep.load()

    # pkg_resources API compatibility
    def resolve(self):
        return self._ep.load()


def iter_entry_points(group):
    eps = entry_points(group=group)
    return [_EPWrapper(ep) for ep in eps]

def get_distribution(name):
    return _Dist(name)

EOF

