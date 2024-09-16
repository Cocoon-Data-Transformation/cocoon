import sys
import os
from pathlib import Path

def main():
    try:
        import streamlit.web.cli as stcli
    except ImportError:
        print("Streamlit is not installed. Please install it to use this feature.")
        sys.exit(1)

    package_dir = Path(__file__).parent.absolute()
    app_path = package_dir / "app.py"

    if not app_path.exists():
        print(f"Error: {app_path} not found.")
        sys.exit(1)

    sys.argv = [
        "streamlit",
        "run",
        str(app_path),
        "--browser.gatherUsageStats=false",
        "--server.runOnSave=false",
        "--server.fileWatcherType=none"
    ]
    stcli.main()

if __name__ == '__main__':
    main()