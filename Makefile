# tts - text-to-speech CLI tool
# See LICENSE file for copyright and license details.

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man/man1
BASHCOMPDIR = /usr/share/bash-completion/completions
ZSHCOMPDIR = /usr/share/zsh/site-functions

# Allow user override
PREFIX ?= /usr/local

all:
	@echo "tts is a shell script, no compilation needed."
	@echo "Run 'make install' to install."

install: install-base install-completions

install-base:
	@echo "Installing tts to $(DESTDIR)$(BINDIR)"
	@mkdir -p $(DESTDIR)$(BINDIR)
	@cp -f tts $(DESTDIR)$(BINDIR)/tts
	@chmod 755 $(DESTDIR)$(BINDIR)/tts
	@echo "Installing man page to $(DESTDIR)$(MANDIR)"
	@mkdir -p $(DESTDIR)$(MANDIR)
	@cp -f man/tts.1 $(DESTDIR)$(MANDIR)/tts.1
	@chmod 644 $(DESTDIR)$(MANDIR)/tts.1

install-completions: install-bash-completion install-zsh-completion
	@echo "Shell completions installed."
	@echo "Installation complete."

install-bash-completion:
	@echo "Installing bash completion to $(DESTDIR)$(BASHCOMPDIR)"
	@mkdir -p $(DESTDIR)$(BASHCOMPDIR)
	@cp -f completions/tts.bash $(DESTDIR)$(BASHCOMPDIR)/tts
	@chmod 644 $(DESTDIR)$(BASHCOMPDIR)/tts

install-zsh-completion:
	@echo "Installing zsh completion to $(DESTDIR)$(ZSHCOMPDIR)"
	@mkdir -p $(DESTDIR)$(ZSHCOMPDIR)
	@cp -f completions/tts.zsh $(DESTDIR)$(ZSHCOMPDIR)/_tts
	@chmod 644 $(DESTDIR)$(ZSHCOMPDIR)/_tts

install-all: install

uninstall:
	@echo "Removing tts from $(DESTDIR)$(BINDIR)"
	@rm -f $(DESTDIR)$(BINDIR)/tts
	@echo "Removing man page from $(DESTDIR)$(MANDIR)"
	@rm -f $(DESTDIR)$(MANDIR)/tts.1
	@echo "Removing bash completion from $(DESTDIR)$(BASHCOMPDIR)"
	@rm -f $(DESTDIR)$(BASHCOMPDIR)/tts
	@echo "Removing zsh completion from $(DESTDIR)$(ZSHCOMPDIR)"
	@rm -f $(DESTDIR)$(ZSHCOMPDIR)/_tts

check:
	@echo "Checking for required dependencies..."
	@command -v curl >/dev/null 2>&1 || { echo "Error: curl is required"; exit 1; }
	@echo "All dependencies found."
	@echo ""
	@echo "Testing tts with --help..."
	@./tts --help >/dev/null 2>&1 || { echo "Error: tts --help failed"; exit 1; }
	@echo "Basic functionality test passed."

dist: clean
	@echo "Creating distribution tarball..."
	@mkdir -p tts-$(VERSION)
	@cp -r tts README LICENSE Makefile man completions tts-$(VERSION)/
	@tar -czf tts-$(VERSION).tar.gz tts-$(VERSION)
	@rm -rf tts-$(VERSION)
	@echo "Created tts-$(VERSION).tar.gz"

clean:
	@rm -f tts-*.tar.gz
	@rm -rf tts-*/

.PHONY: all install install-bash-completion install-zsh-completion install-all uninstall check dist clean