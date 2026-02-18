#!/usr/bin/env bash
# fix-mopidy-pkg-resources.sh
set -euo pipefail

MOPIDY_SITE="/opt/homebrew/Cellar/mopidy/3.4.2_1/libexec/lib/python3.11/site-packages/mopidy"
echo "Patching pkg_resources..."


cat <<'EOF' > "$MOPIDY_SITE/pkg_resources.py"
# shim for deprecated pkg_resources
from importlib_resources import files as resource_files, as_file
from importlib_metadata import PackageNotFoundError, distribution

def resource_filename(package, resource):
    try:
        return str(as_file(resource_files(package) / resource))
    except PackageNotFoundError:
        raise FileNotFoundError(f"{resource} not found in {package}")
EOF

echo "Done. Mopidy should now start without ModuleNotFoundError."