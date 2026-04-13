#!/bin/bash
set -euo pipefail

INSTALL_DIR="$HOME/.hey-rovo"
BIN_DIR="$HOME/bin"

echo "Installing hey-rovo..."

# Download
mkdir -p "$INSTALL_DIR" "$BIN_DIR"
curl -fsSL https://raw.githubusercontent.com/otherland/hey-rovo/main/rovo -o "$INSTALL_DIR/rovo"
chmod +x "$INSTALL_DIR/rovo"

# Create .env if missing
if [ ! -f "$INSTALL_DIR/.env" ]; then
  curl -fsSL https://raw.githubusercontent.com/otherland/hey-rovo/main/.env.example -o "$INSTALL_DIR/.env"
fi

# Point the script at ~/.hey-rovo for its .env
cat > "$BIN_DIR/rovo" << 'EOF'
#!/bin/bash
ROVO_ENV_FILE="$HOME/.hey-rovo/.env" exec "$HOME/.hey-rovo/rovo" "$@"
EOF
chmod +x "$BIN_DIR/rovo"

# Check PATH
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  SHELL_RC="$HOME/.$(basename "$SHELL")rc"
  echo "export PATH=\"\$HOME/bin:\$PATH\"" >> "$SHELL_RC"
  echo "Added ~/bin to PATH in $SHELL_RC (restart your shell or run: source $SHELL_RC)"
fi

echo ""
echo "Installed. Now edit ~/.hey-rovo/.env with your session token."
echo "See https://github.com/otherland/hey-rovo#setup for how to grab it."
