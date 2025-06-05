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
curl -fsSL "https://raw.githubusercontent.com/jtgi/tts/main/tts" -o "$BINDIR/tts" || \
    error "Failed to download tts"

chmod +x "$BINDIR/tts" || error "Failed to make tts executable"

success "✓ tts installed to $BINDIR/tts"

# Install shell completions
install_completions() {
    local shell_name="$1"
    local completion_url="$2"
    local completion_dir="$3"
    local completion_file="$4"
    
    if [ -d "$completion_dir" ]; then
        info "Installing $shell_name completion..."
        if curl -fsSL "$completion_url" -o "$completion_dir/$completion_file" 2>/dev/null; then
            success "✓ $shell_name completion installed"
        else
            warning "⚠ Failed to install $shell_name completion (non-fatal)"
        fi
    fi
}

# Try to install completions for common shells
if [ "$PREFIX" = "/usr/local" ] || [ "$PREFIX" = "/usr" ]; then
    # System-wide installation
    install_completions "bash" \
        "https://raw.githubusercontent.com/jtgi/tts/main/completions/tts.bash" \
        "/usr/share/bash-completion/completions" \
        "tts"
    
    install_completions "zsh" \
        "https://raw.githubusercontent.com/jtgi/tts/main/completions/tts.zsh" \
        "/usr/share/zsh/site-functions" \
        "_tts"
else
    # User installation - try common user directories
    install_completions "bash" \
        "https://raw.githubusercontent.com/jtgi/tts/main/completions/tts.bash" \
        "$HOME/.local/share/bash-completion/completions" \
        "tts"
    
    install_completions "zsh" \
        "https://raw.githubusercontent.com/jtgi/tts/main/completions/tts.zsh" \
        "$HOME/.local/share/zsh/site-functions" \
        "_tts"
    
    # Also try XDG directories
    if [ -n "$XDG_DATA_HOME" ]; then
        install_completions "bash" \
            "https://raw.githubusercontent.com/jtgi/tts/main/completions/tts.bash" \
            "$XDG_DATA_HOME/bash-completion/completions" \
            "tts"
        
        install_completions "zsh" \
            "https://raw.githubusercontent.com/jtgi/tts/main/completions/tts.zsh" \
            "$XDG_DATA_HOME/zsh/site-functions" \
            "_tts"
    fi
fi

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