#!/bin/sh
# Runs `witness hook --agent claude-code <event>` for the plugin's hooks when
# the witness binary is installed, and does nothing otherwise. It always
# exits 0, so a hook never blocks Claude Code. The binary is installed
# separately (see README.md); this script downloads and installs nothing.
W=$(command -v witness || echo "$HOME/.local/bin/witness")
[ -x "$W" ] || W="$HOME/.cargo/bin/witness"
if [ ! -x "$W" ]; then
  if [ "$1" = session-start ] && [ -d .witness ]; then
    echo '{"systemMessage":"Witness: the witness binary is not installed, so this session is not recorded. Install it: curl -fsSL https://raw.githubusercontent.com/radical-studios/witness/main/install.sh | sh"}'
  fi
  exit 0
fi
"$W" hook --agent claude-code "$1" || true
