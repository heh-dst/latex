#!/usr/bin/env python3
"""
Installation script for HEH-DST LaTeX classes and fonts.
Works on Linux, Windows, and macOS.
"""

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


def get_texmf_home() -> Path:
    """Get the user's TEXMFHOME directory."""
    print("Detecting TEXMFHOME directory...")
    texmf_home = run_command("kpsewhich -var-value=TEXMFHOME")

    if not texmf_home:
        print("Error: Could not detect TEXMFHOME. Is TeX Live installed?")
        sys.exit(1)

    texmf_path = Path(texmf_home).expanduser()
    print(f"TEXMFHOME: {texmf_path}")
    return texmf_path


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


def copy_file(src: Path, dest: Path, description: str) -> bool:
    """Copy a single file to the destination (only if modified)."""
    if not src.exists():
        print(f"  ⚠ Warning: Source file not found: {src}")
        return False

    ensure_directory(dest.parent)

    if should_copy_file(src, dest):
        shutil.copy2(src, dest)
        print(f"  ✓ Installed {description}: {dest}")
    else:
        print(f"  → {description} up to date: {dest}")

    return True


def main():
    print("=" * 80)
    print("HEH-DST LaTeX Classes and Fonts Installation")
    print("=" * 80)
    print()

    # Get the script directory (repository root)
    repo_root = Path(__file__).parent.parent.resolve()
    print(f"Repository root: {repo_root}")
    print()

    # Get TEXMFHOME directory
    texmf_home = get_texmf_home()
    print()

    # Initialize user tree if needed
    print("Initializing TeX user tree...")
    run_command("tlmgr init-usertree", check=False)
    print()

    # Install AMC class
    print("Installing AMC class...")
    amc_src = repo_root / "amc" / "heh-amc.cls"
    amc_dest = texmf_home / "tex" / "latex" / "heh-amc" / "heh-amc.cls"
    copy_file(amc_src, amc_dest, "heh-amc class")
    print()

    # Install fonts
    print("Installing fonts...")

    # Luciole fonts
    fonts_installed: list[str] = []

    luciole_latex_src = repo_root / "fonts" / "luciole-latex"
    luciole_latex_dest = texmf_home / "tex" / "latex" / "luciole"
    if copy_directory(luciole_latex_src, luciole_latex_dest, "Luciole LaTeX support"):
        fonts_installed.append("Luciole")

    luciole_opentype_src = repo_root / "fonts" / "luciole-opentype"
    luciole_opentype_dest = texmf_home / "fonts" / "opentype" / "public" / "luciole"
    copy_directory(
        luciole_opentype_src, luciole_opentype_dest, "Luciole OpenType fonts"
    )

    luciole_truetype_src = repo_root / "fonts" / "luciole-truetype"
    luciole_truetype_dest = texmf_home / "fonts" / "truetype" / "public" / "luciole"
    copy_directory(
        luciole_truetype_src, luciole_truetype_dest, "Luciole TrueType fonts"
    )

    # IntoneMonoNerdFont
    intone_latex_src = repo_root / "fonts" / "IntoneMonoNerdFont-latex"
    intone_latex_dest = texmf_home / "tex" / "latex" / "IntoneMonoNerdFont"
    if copy_directory(
        intone_latex_src, intone_latex_dest, "IntoneMonoNerdFont LaTeX support"
    ):
        fonts_installed.append("IntoneMonoNerdFont")

    intone_truetype_src = repo_root / "fonts" / "IntoneMonoNerdFont-truetype"
    intone_truetype_dest = (
        texmf_home / "fonts" / "truetype" / "public" / "IntoneMonoNerdFont"
    )
    copy_directory(
        intone_truetype_src, intone_truetype_dest, "IntoneMonoNerdFont TrueType fonts"
    )

    print()

    # Install required packages
    print("Installing required TeX packages...")
    print("  → Installing realscripts package...")
    result = run_command("tlmgr --usermode install realscripts", check=False)
    if result is not None:
        print("  ✓ realscripts installed")
    else:
        print("  ⚠ Could not install realscripts (may already be installed)")
    print()

    # Refresh TeX database
    print("Refreshing TeX filename database...")
    run_command("mktexlsr", check=False, capture_output=False)
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
