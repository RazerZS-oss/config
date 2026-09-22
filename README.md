# 🚀 Mac M1 Speed & Productivity Configurations

This repository contains high-impact performance optimizations and workflow tweaks for macOS Apple Silicon (M1/M2/M3).

---

## ⚡ 1. Zsh Shell Launch Optimizations

Your existing modular configuration in `~/.zshrc.d/` has been optimized to eliminate startup delays:

- **Cached `compinit`**: Re-indexes completions only once every 24 hours (and byte-compiles `.zcompdump.zwc` in the background) instead of rescanning the filesystem on every new tab or pane.
- **Cached `LS_COLORS`**: Generates `vivid generate snazzy` once into a cache file (`~/.cache/ls_colors_snazzy`) and reads it instantly using fast native Zsh file expansion `$(<file)` rather than spawning an external Ruby/Rust binary on startup.
- **Conditional `brew shellenv`**: Skips re-evaluating `brew shellenv` if `HOMEBREW_PREFIX` is already set by `~/.zprofile`.

### How to apply:
Run the prepared script (it will automatically make `.bak` backups of your original files first):
```bash
./apply_zsh.sh
```

---

## 🏎️ 2. macOS UI & System Responsiveness (`macos_speedup.sh`)

Eliminates artificial animation delays and sluggish defaults across macOS:

- **Instant Keyboard Repeat**: Eliminates delay before keys repeat and accelerates repeat speed to 15ms (ideal for Vim navigation and fast editing). Disables the press-and-hold character accent menu.
- **Zero Dock Delay**: Dock appears immediately on hover without the default 0.5s hesitation, and animates quickly (0.12s).
- **Window Resize & Dialogs**: Reduces window resize time and auto-expands Save/Print dialogues.
- **Finder**: Disables Finder animations and shows the breadcrumb path bar and status bar.

### How to run:
```bash
./macos_speedup.sh
```

### How to revert anytime:
If you ever want to restore standard macOS factory defaults:
```bash
./macos_speedup.sh --revert
```
