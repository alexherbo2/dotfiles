PREFIX ?= $(HOME)/.local

build:

install:
	install -d $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(PREFIX)/share
	install -m 0755 kamux.sh $(DESTDIR)$(PREFIX)/bin/kamux
	install -m 0644 kamux.conf $(DESTDIR)$(PREFIX)/share/kamux.conf

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/kamux $(DESTDIR)$(PREFIX)/share/kamux.conf
