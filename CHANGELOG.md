# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Removed

## 0.0.0

### Added

- This `CHANGELOG.md` file. The old changelog can be found in [unicode/CHANGELOG.txt](unicode/CHANGELOG.txt).
- The actual text of GPLv3 license.
- `pyproject.toml`
- Nix stuff.
- Ability to override path to unicode data using `UNICODE_DATA_DIR` env variable.

### Changed

- Changed the name from `unicode` to `unisearch`.
- Switched from `setup.py` to `pyproject.toml` with `uv`.
- Make checks for existence of `grep` & friends more robust.
- Unless the old `~/.unicode/` dir exists, use `~/.local/share/unicode/` instead (respecting `$XDG_DATA_HOME`).

### Removed

- Python 2 support. Come on, it's 2025.
- Windows and MacOS support. (If there was any to begin with.)
- `paracode` cli utility.
- `setup.py`
- Debian packaging infrastructure.
