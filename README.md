# ⚡ macOS Apple Silicon Speed & Workflow Suite

<p align="center">
  <img src="https://img.shields.io/badge/macOS-Apple%20Silicon%20(M1%2FM2%2FM3%2FM4)-black?style=for-the-badge&logo=apple" alt="macOS Apple Silicon" />
  <img src="https://img.shields.io/badge/Shell-Zsh%20%26%20Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell" />
  <img src="https://img.shields.io/badge/Optimized%20For-Speed%20%26%20Responsiveness-blue?style=for-the-badge" alt="Speed" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License" />
</p>

A curated collection of high-impact speed optimizations, UI responsiveness tweaks, and shell startup accelerations tailored specifically for **Apple Silicon Macs (M1 / M2 / M3 / M4)**.

Apple Silicon hardware is blisteringly fast, but out-of-the-box macOS defaults introduce **artificial animation delays**, **slow keyboard repeat pauses**, and **redundant shell initialization scans**. This repository removes those bottlenecks to give you an instantaneous, fluid developer experience.

---

## 📑 Table of Contents

- [✨ Highlights](#-highlights)
- [📦 What's Inside](#-whats-inside)
- [🚀 Quick Start Guide](#-quick-start-guide)
  - [1. Apply macOS UI Speedups](#1-apply-macos-ui-speedups)
  - [2. Apply Zsh Startup Optimizations](#2-apply-zsh-startup-optimizations)
- [🔍 Detailed Breakdown of Tweaks](#-detailed-breakdown-of-tweaks)
  - [macOS UI & System Responsiveness (`macos_speedup.sh`)](#macos-ui--system-responsiveness-macos_speedupsh)
  - [Zsh Launch Speedups (`10-env.zsh` & `20-completion.zsh`)](#zsh-launch-speedups-10-envzsh--20-completionzsh)
- [🔄 How to Revert](#-how-to-revert)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

## ✨ Highlights

- 🏎️ **Zero-Delay Dock**: Hovering over the Dock shows it immediately without the default 0.5-second lag, with a crisp 0.12s slide animation.
- ⌨️ **Instant Keyboard Repeat**: Eliminates cursor delay and sets a hyper-fast 15ms repeat rate—essential for Vim navigation and rapid code editing.
- ⚡ **Sub-15ms Zsh Startup**: Replaces slow `compinit` filesystem scans with smart 24-hour cache invalidation and byte-compilation (`.zwc`).
- 🎨 **Cached `LS_COLORS`**: Generates `vivid` syntax styles once and reads them via native Zsh file expansion instead of spawning external subshells.
- 🛡️ **Non-Destructive & Safe**: Built-in `--revert` flag to restore macOS factory defaults, and automatic `.bak` backups before modifying any shell files.

---

## 📦 What's Inside

```plaintext
.
├── README.md             # Documentation and usage guide
├── macos_speedup.sh      # Script to eliminate macOS animation lag & set fast key repeat
├── apply_zsh.sh          # One-step installer that backs up and links optimized Zsh modules
├── 10-env.zsh            # High-efficiency environment loader (avoids duplicate brew checks)
└── 20-completion.zsh     # Fast cached compinit & LS_COLORS loader
```

---

## 🚀 Quick Start Guide

### Prerequisites
- macOS running on Apple Silicon (M1, M2, M3, M4)
- Zsh shell (default on macOS)
- [Homebrew](https://brew.sh) (recommended)

### Installation

Clone this repository to your preferred directory:

```bash
git clone https://github.com/RazerZS-oss/config.git ~/project/config
cd ~/project/config
```

---

### 1. Apply macOS UI Speedups

Run the `macos_speedup.sh` script to strip out UI latency:

```bash
chmod +x macos_speedup.sh
./macos_speedup.sh
```

> **Note**: For keyboard repeat rates to take full effect across every application, log out and log back into your Mac user account (or restart your Mac).

---

### 2. Apply Zsh Startup Optimizations

If you use a modular Zsh setup (like `~/.zshrc.d/`):

```bash
chmod +x apply_zsh.sh
./apply_zsh.sh
source ~/.zshrc
```

The script will automatically back up your existing files as `~/.zshrc.d/*.bak` before applying the new configuration.

---

## 🔍 Detailed Breakdown of Tweaks

### macOS UI & System Responsiveness (`macos_speedup.sh`)

| Setting | Default Behavior | Optimized Behavior | Why it matters |
| :--- | :--- | :--- | :--- |
| **`InitialKeyRepeat`** | `25` (375ms pause) | `12` (180ms delay) | Keys begin repeating much faster when held down. |
| **`KeyRepeat`** | `6` (90ms interval) | `1` (15ms interval) | Cursor moves across lines at lightning speed. |
| **`ApplePressAndHoldEnabled`**| `true` (popup accent menu) | `false` | Enables real key repeating (essential for Vim navigation). |
| **`autohide-delay`** | `0.5` seconds | `0` seconds | Dock pops up immediately without pausing. |
| **`autohide-time-modifier`** | `0.5` seconds | `0.12` seconds | Snappy, modern animation instead of floaty slide. |
| **`NSWindowResizeTime`** | `0.2` seconds | `0.001` seconds | Windows snap to size instantly. |
| **`DisableAllAnimations`** | `false` | `true` | Eliminates opening/closing zoom delays in Finder. |
| **`ShowPathbar` & `ShowStatusBar`** | `false` | `true` | Shows full folder paths and available storage space. |
| **`DSDontWriteNetworkStores`** | `false` | `true` | Stops polluting network and external USB drives with `.DS_Store`. |

---

### Zsh Launch Speedups (`10-env.zsh` & `20-completion.zsh`)

#### The Problem with Default Zsh Setups
1. **Uncached `compinit`**: Every time you open a terminal tab or split a pane, Zsh scans every executable in your `$fpath`. On macOS with Homebrew, this involves thousands of files and causes 50–150ms of lag.
2. **Dynamic `vivid` execution**: Generating color maps on every startup spawns an external process that wastes CPU cycles.
3. **Duplicate `brew shellenv`**: Running `brew shellenv` repeatedly runs Ruby wrappers and subshells that aren't necessary if the path is already set.

#### The Solution in This Repo
- **24-Hour Dump Cache**: Uses `stat` to check if `~/.zcompdump` is less than 24 hours old. If so, it loads instantly using `compinit -C` (bypassing security scans).
- **Background Byte-Compilation**: Runs `zcompile ~/.zcompdump` in the background (`&!`), so Zsh reads pre-compiled bytecode on subsequent loads.
- **Cache-First LS_COLORS**: Writes the color output to `~/.cache/ls_colors_snazzy` once and loads it with zero subprocess overhead via `$(<"$lscache")`.

---

## 🔄 How to Revert

If you ever want to restore factory defaults, everything is completely reversible:

### Revert macOS UI Settings:
```bash
./macos_speedup.sh --revert
```

### Revert Zsh Modules:
```bash
mv ~/.zshrc.d/10-env.zsh.bak ~/.zshrc.d/10-env.zsh
mv ~/.zshrc.d/20-completion.zsh.bak ~/.zshrc.d/20-completion.zsh
source ~/.zshrc
```

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! If you have additional Apple Silicon performance tweaks or shell optimizations, feel free to open a Pull Request.

---

## 📄 License

Distributed under the [MIT License](LICENSE). Feel free to use, modify, and distribute for personal and commercial projects.
