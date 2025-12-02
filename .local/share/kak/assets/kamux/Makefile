PREFIX ?= $(HOME)/.local

build:

install:
	install -d $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(PREFIX)/share
	install -m 0755 kamux.sh $(DESTDIR)$(PREFIX)/bin/kamux
	install -m 0755 kamux-terminal.sh $(DESTDIR)$(PREFIX)/bin/kamux-terminal
	install -m 0644 kamux.conf $(DESTDIR)$(PREFIX)/share/kamux.conf
	install -m 0644 kamux_terminal.conf $(DESTDIR)$(PREFIX)/share/kamux_terminal.conf

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/kamux $(DESTDIR)$(PREFIX)/bin/kamux-terminal $(DESTDIR)$(PREFIX)/share/kamux.conf $(DESTDIR)$(PREFIX)/share/kamux_terminal.conf
