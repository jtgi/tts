#!/bin/sh
# Quick install script for tts

set -e

# Default installation directory
PREFIX="${PREFIX:-$HOME/.local}"
BINDIR="$PREFIX/bin"

# Colors
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m'
else
    RED=''
    GREEN=''
    YELLOW=''
    NC=''
fi

error() {
    printf "${RED}Error: %s${NC}\n" "$1" >&2
    exit 1
}

info() {
    printf "%s\n" "$1"
}

success() {
    printf "${GREEN}%s${NC}\n" "$1"
}

warning() {
    printf "${YELLOW}%s${NC}\n" "$1"
}

# Check dependencies
command -v curl >/dev/null 2>&1 || error "curl is required but not installed"

# Create bin directory
mkdir -p "$BINDIR" || error "Failed to create $BINDIR"

# Download tts
info "Downloading tts..."
curl -fsSL "https://raw.githubusercontent.com/yourusername/tts/main/tts" -o "$BINDIR/tts" || \
    error "Failed to download tts"

chmod +x "$BINDIR/tts" || error "Failed to make tts executable"

success "✓ tts installed to $BINDIR/tts"

# Check PATH
case ":$PATH:" in
    *":$BINDIR:"*)
        ;;
    *)
        warning ""
        warning "Note: $BINDIR is not in your PATH"
        warning "Add this to your shell configuration:"
        warning "  export PATH=\"\$PATH:$BINDIR\""
        ;;
esac

info ""
info "Get started:"
info "  export ELEVENLABS_API_KEY='your-api-key'"
info "  echo 'Hello world' | tts > hello.mp3"
info ""
info "For more options: tts --help"