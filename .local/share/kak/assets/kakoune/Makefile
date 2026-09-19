PREFIX ?= $(HOME)/.local

build:

install:
	install -d $(DESTDIR)$(PREFIX)/share/bash-completion/completions $(DESTDIR)$(PREFIX)/share/zsh/site-functions $(DESTDIR)$(PREFIX)/share/fish/vendor_completions.d $(DESTDIR)$(PREFIX)/share/elvish/lib $(DESTDIR)$(PREFIX)/share/nushell/vendor/autoload
	install -m 0644 shell-completion/kak.bash $(DESTDIR)$(PREFIX)/share/bash-completion/completions
	install -m 0644 shell-completion/kak.zsh $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_kak
	install -m 0644 shell-completion/kak.fish $(DESTDIR)$(PREFIX)/share/fish/vendor_completions.d
	install -m 0644 shell-completion/kak-completions.elv $(DESTDIR)$(PREFIX)/share/elvish/lib
	install -m 0644 shell-completion/kak-completions.nu $(DESTDIR)$(PREFIX)/share/nushell/vendor/autoload

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/bash-completion/completions/kak.bash $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_kak $(DESTDIR)$(PREFIX)/share/fish/vendor_completions.d/kak.fish $(DESTDIR)$(PREFIX)/share/elvish/lib/kak-completions.elv $(DESTDIR)$(PREFIX)/share/nushell/vendor/autoload/kak-completions.nu
