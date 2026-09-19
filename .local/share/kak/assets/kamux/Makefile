PREFIX ?= $(HOME)/.local

build:

install:
	install -d $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(PREFIX)/share $(DESTDIR)$(PREFIX)/share/bash-completion/completions $(DESTDIR)$(PREFIX)/share/zsh/site-functions $(DESTDIR)$(PREFIX)/share/fish/vendor_completions.d $(DESTDIR)$(PREFIX)/share/elvish/lib $(DESTDIR)$(PREFIX)/share/nushell/vendor/autoload
	install -m 0755 kamux.sh $(DESTDIR)$(PREFIX)/bin/kamux
	install -m 0644 kamux.conf $(DESTDIR)$(PREFIX)/share/kamux.conf
	install -m 0644 shell-completion/kamux.bash $(DESTDIR)$(PREFIX)/share/bash-completion/completions
	install -m 0644 shell-completion/kamux.zsh $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_kamux
	install -m 0644 shell-completion/kamux.fish $(DESTDIR)$(PREFIX)/share/fish/vendor_completions.d
	install -m 0644 shell-completion/kamux-completions.elv $(DESTDIR)$(PREFIX)/share/elvish/lib
	install -m 0644 shell-completion/kamux-completions.nu $(DESTDIR)$(PREFIX)/share/nushell/vendor/autoload

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/kamux $(DESTDIR)$(PREFIX)/share/kamux.conf $(DESTDIR)$(PREFIX)/share/bash-completion/completions/kamux.bash $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_kamux $(DESTDIR)$(PREFIX)/share/fish/vendor_completions.d/kamux.fish $(DESTDIR)$(PREFIX)/share/elvish/lib/kamux-completions.elv $(DESTDIR)$(PREFIX)/share/nushell/vendor/autoload/kamux-completions.nu
