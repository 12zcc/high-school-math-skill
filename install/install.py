#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Install the high-school-math skill for the most common AI coding tools.

Usage:
    python install.py            # install to global dirs for detected tools
    python install.py --project  # also install into the current project
    python install.py --list     # only print detected tools/install targets

Works on Windows / macOS / Linux (Python 3.8+). No third-party deps.
"""

import argparse
import os
import shutil
import sys

BASE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(BASE)

SKILL_DIR = os.path.join(ROOT, "high-school-math")          # contains SKILL.md
SKILL_MD = os.path.join(SKILL_DIR, "SKILL.md")
CURSOR_RULE = os.path.join(ROOT, ".cursor", "rules", "high-school-math.mdc")
COPILOT_MD = os.path.join(ROOT, ".github", "copilot-instructions.md")

NAME = "high-school-math"


def home():
    return os.path.expanduser("~")


def project_scope(cwd):
    return {
        "opencode (project)": os.path.join(cwd, ".opencode", "skills", NAME),
        "claude (project)": os.path.join(cwd, ".claude", "skills", NAME),
        "copilot (project)": os.path.join(cwd, ".github", "copilot-instructions.md"),
    }


def global_scope():
    home_dir = home()
    return {
        "claude code": os.path.join(home_dir, ".claude", "skills", NAME),
        "opencode": os.path.join(home_dir, ".config", "opencode", "skills", NAME),
        "agents/skills": os.path.join(home_dir, ".agents", "skills", NAME),
        "cursor (rule)": os.path.join(home_dir, ".cursor", "rules", NAME + ".mdc"),
    }


def copy_file(src, dst):
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    shutil.copy2(src, dst)
    return dst


def copy_dir(src, dst):
    os.makedirs(os.path.dirname(dst), exist_ok=True)
    if os.path.exists(dst):
        shutil.rmtree(dst)
    shutil.copytree(src, dst)
    return dst


def install(targets, dry_run=False):
    installed = []
    for label, dst in targets.items():
        if dry_run:
            print(f"  [dry-run] would install -> {label}: {dst}")
            continue
        try:
            if label.startswith("cursor"):
                actual = copy_file(CURSOR_RULE, dst)
            elif label.startswith("copilot"):
                actual = copy_file(COPILOT_MD, dst)
            else:
                actual = copy_dir(SKILL_DIR, dst)
            installed.append((label, actual))
            print(f"  [ok] {label}: {actual}")
        except Exception as exc:  # noqa: BLE001
            print(f"  [skip] {label}: {exc}")
    return installed


def main():
    parser = argparse.ArgumentParser(description="Install high-school-math skill for AI tools")
    parser.add_argument("--project", action="store_true",
                        help="also install into the current project (.opencode/.claude/.github)")
    parser.add_argument("--list", action="store_true",
                        help="only print detected install targets, do not write anything")
    args = parser.parse_args()

    targets = global_scope()
    if args.project:
        targets.update(project_scope(os.getcwd()))

    print("high-school-math skill installer")
    print("=" * 50)
    if args.list:
        for label, dst in targets.items():
            print(f"  {label}: {dst}")
        return

    if not os.path.exists(SKILL_MD):
        print(f"ERROR: {SKILL_MD} not found — run this script from install/ inside the repo.")
        sys.exit(1)

    done = install(targets)
    print("=" * 50)
    print(f"Installed {len(done)}/{len(targets)} targets.")
    if len(done) < len(targets):
        print("Skipped targets are usually because that tool's config dir does not exist yet;")
        print("create it manually or launch the tool once, then re-run.")
    print("\nRestart your AI tool(s) so the skill is (re)loaded.")


if __name__ == "__main__":
    main()
