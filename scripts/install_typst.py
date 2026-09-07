#!/usr/bin/env python3
"""
Installation script for HEH-DST Typst packages.
Works on Linux, Windows, and macOS. Does not require a LaTeX installation.
"""

import json
import shutil
import subprocess
import sys
from pathlib import Path


def run_command(
    cmd: str, check: bool = True, capture_output: bool = True
) -> str | None:
    """Execute a shell command and return the result."""
    try:
        result = subprocess.run(
            cmd,
            shell=True,
            check=check,
            capture_output=capture_output,
            text=True,
        )
        return result.stdout.strip() if capture_output else None
    except subprocess.CalledProcessError as e:
        if check:
            print(f"Error executing command: {cmd}")
            print(f"Error message: {e.stderr}")
            raise
        return None


def get_typst_package_dir() -> Path:
    """Get the Typst local package directory."""
    print("Detecting Typst package directory...")
    typst_info = run_command("typst info --format json", check=False)

    if not typst_info:
        print("Error: Could not detect Typst package directory. Is Typst installed?")
        sys.exit(1)

    package_path = json.loads(typst_info)["packages"]["package-path"]
    typst_path = Path(package_path).expanduser()
    print(f"Typst package directory: {typst_path}")
    return typst_path


def ensure_directory(path: Path) -> None:
    """Create directory if it doesn't exist."""
    path.mkdir(parents=True, exist_ok=True)


def should_copy_file(src: Path, dest: Path) -> bool:
    """Check if a file needs to be copied (newer or different size)."""
    if not dest.exists():
        return True

    src_stat = src.stat()
    dest_stat = dest.stat()

    # Copy if size differs or source is newer
    return (
        src_stat.st_size != dest_stat.st_size or src_stat.st_mtime > dest_stat.st_mtime
    )


def copy_directory(src: Path, dest: Path, description: str) -> bool:
    """Copy a directory tree to the destination (only modified files)."""
    if not src.exists():
        print(f"  ⚠ Warning: Source directory not found: {src}")
        return False

    ensure_directory(dest)

    copied_count = 0
    skipped_count = 0

    for src_file in src.rglob("*"):
        if src_file.is_file():
            # Compute relative path and destination
            rel_path = src_file.relative_to(src)
            dest_file = dest / rel_path

            if should_copy_file(src_file, dest_file):
                ensure_directory(dest_file.parent)
                shutil.copy2(src_file, dest_file)
                copied_count += 1
            else:
                skipped_count += 1

    if copied_count > 0:
        print(
            f"  ✓ Installed {description}: {dest} ({copied_count} files copied, {skipped_count} unchanged)"
        )
    else:
        print(f"  → {description} up to date: {dest} ({skipped_count} files)")

    return True


def main():
    print("=" * 80)
    print("HEH-DST Typst Packages Installation")
    print("=" * 80)
    print()

    # Get the script directory (repository root)
    repo_root = Path(__file__).parent.parent.resolve()
    print(f"Repository root: {repo_root}")
    print()

    # Install HEH Typst resources
    print("Installing HEH Typst resources...")
    typst_src = repo_root / "typst"
    typst_dest = get_typst_package_dir() / "heh-dst"
    copy_directory(typst_src, typst_dest, "Typst files")
    print()

    print("=" * 80)
    print("Installation complete!")
    print("=" * 80)
    print()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nInstallation cancelled by user.")
        sys.exit(1)
    except Exception as e:
        print(f"\n\nError during installation: {e}")
        sys.exit(1)
