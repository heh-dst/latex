#!/usr/bin/env python3
"""
Installation script for HEH-DST LaTeX classes and fonts.
Works on Linux, Windows, and macOS.
"""

import re
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


def extract_amc_sty(repo_root: Path, texmf_home: Path) -> bool:
    """Extract automultiplechoice.sty from .dtx.in if AMC is not installed."""
    print("Checking for Auto Multiple Choice package...")

    # Check if AMC is already available in the system
    amc_system_check = run_command("kpsewhich automultiplechoice.sty", check=False)
    if amc_system_check:
        print(f"  → AMC already available (system): {amc_system_check}")
        return True

    # Check if we already installed it
    amc_user_dest = (
        texmf_home / "tex" / "latex" / "automultiplechoice" / "automultiplechoice.sty"
    )
    if amc_user_dest.exists():
        print(f"  → AMC already installed (user): {amc_user_dest}")
        return True

    # Try to extract from .dtx.in
    dtx_in_path = (
        repo_root / "auto-multiple-choice" / "tex" / "automultiplechoice.dtx.in"
    )
    if not dtx_in_path.exists():
        print(f"  ⚠ Warning: AMC source not found at {dtx_in_path}")
        print("     AMC package will need to be installed separately for compilation.")
        return False

    print(f"  → Extracting automultiplechoice.sty from {dtx_in_path.name}...")

    # Read the .dtx.in file
    dtx_content = dtx_in_path.read_text(encoding="utf-8")

    # Get version from ChangeLog
    version = "0.0.0"  # Default fallback
    year = "1970"
    month = "01"
    day = "01"
    changelog_file = repo_root / "auto-multiple-choice" / "ChangeLog"
    if changelog_file.exists():
        changelog_content = changelog_file.read_text(encoding="utf-8")
        # First line format: "1.7.0 (2025-04-17)"
        version_match = re.match(
            r"^([0-9~:.a-z+-]+)\s+\((\d{4})-(\d{2})-(\d{2})\)", changelog_content
        )
        if version_match:
            version = version_match.group(1)
            year = version_match.group(2)
            month = version_match.group(3)
            day = version_match.group(4)

    # Format version string for .sty file
    version_sty = f"{year}/{month}/{day} v{version}"
    pdfdate = f"{year}{month}{day}000000"

    # Replace placeholders in the .dtx.in template
    dtx_content = re.sub(r"@/PACKAGE_V_STY_TEX/@", version_sty, dtx_content)
    dtx_content = re.sub(r"@/PACKAGE_V_PDFDATE/@", pdfdate, dtx_content)

    # Work directly in the AMC tex directory (files are gitignored)
    amc_tex_dir = repo_root / "auto-multiple-choice" / "tex"
    dtx_file = amc_tex_dir / "automultiplechoice.dtx"
    sty_file = amc_tex_dir / "automultiplechoice.sty"

    # Write the processed .dtx file
    dtx_file.write_text(dtx_content, encoding="utf-8")

    # Extract the .sty file using pdflatex
    print("  → Running pdflatex to extract .sty file...")
    run_command(
        f'cd "{amc_tex_dir}" && pdflatex -interaction=batchmode automultiplechoice.dtx',
        check=False,
        capture_output=False,
    )
    run_command(
        f'cd "{amc_tex_dir}" && git clean -f',
        check=False,
        capture_output=False,
    )

    if not sty_file.exists():
        print("  ✗ Failed to extract automultiplechoice.sty")
        print("     AMC package will need to be installed separately.")
        # Clean up the .dtx file
        if dtx_file.exists():
            dtx_file.unlink()
        return False

    # Copy the extracted .sty to texmf
    ensure_directory(amc_user_dest.parent)
    shutil.copy2(sty_file, amc_user_dest)
    print(f"  ✓ Extracted and installed automultiplechoice.sty: {amc_user_dest}")

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

    # Extract and install AMC package if not available
    extract_amc_sty(repo_root, texmf_home)
    print()

    # Install HEH common resources
    print("Installing HEH common resources...")
    common_sty_src = repo_root / "common" / "heh-common.sty"
    common_sty_dest = texmf_home / "tex" / "latex" / "heh-dst" / "heh-common.sty"
    copy_file(common_sty_src, common_sty_dest, "heh-common package")
    print()

    # Install shared graphics
    print("Installing shared graphics...")
    graphics_src = repo_root / "common" / "graphics"
    graphics_dest = texmf_home / "tex" / "latex" / "heh-dst" / "graphics"
    copy_directory(graphics_src, graphics_dest, "HEH shared graphics")
    print()

    # Install AMC class
    print("Installing AMC class...")
    amc_src = repo_root / "amc" / "heh-amc.cls"
    amc_dest = texmf_home / "tex" / "latex" / "heh-dst" / "heh-amc.cls"
    copy_file(amc_src, amc_dest, "heh-amc class")
    print()

    # Install beamer files
    print("Installing beamer files...")
    beamer_src = repo_root / "beamer"
    beamer_dest = texmf_home / "tex" / "latex" / "heh-dst"
    copy_directory(beamer_src, beamer_dest, "heh-beamer files")
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

    # Check if realscripts is already installed
    realscripts_check = run_command("kpsewhich realscripts.sty", check=False)
    if realscripts_check:
        print(f"  → realscripts already installed: {realscripts_check}")
    else:
        print("  → Installing realscripts package...")
        result = run_command("tlmgr --usermode install realscripts", check=False)
        if result is not None:
            print("  ✓ realscripts installed")
        else:
            print("  ⚠ Could not install realscripts")
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
