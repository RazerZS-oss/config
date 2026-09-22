# Homebrew & Environment Variables
# Fast check: only run brew shellenv if HOMEBREW_PREFIX isn't already exported
if [[ -z "$HOMEBREW_PREFIX" && -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

export BAT_THEME="Dracula"
export CLICOLOR=1
export EDITOR='micro'

# Antigravity CLI PATH
export PATH="/Users/roy/.local/bin:$PATH"
