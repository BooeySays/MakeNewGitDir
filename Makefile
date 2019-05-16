PREFIX ?= /usr/local
BOOEYSAYS = ~/.booeysays
FUNCDIR = $(DESTDIR)$(BOOEYSAYS)/functions
MANDIR = $(DESTDIR)$(PREFIX)/share/man/man1
DOCDIR = $(DESTDIR)$(PREFIX)/share/doc/mkgit

#.PHONY: all install uninstall disable-self-upgrade

all:

install:
	install -m755 -d $(FUNCDIR)
	install -m755 -d $(MANDIR)
	install -m755 -d $(DOCDIR)
#	gzip -c mkgit.1 > mkgit.1.gz
	install -m755 mkgitdir.sh $(FUNCDIR)
#	install -m644 mkgit.1.gz $(MANDIR)
	install -m644 README.md $(DOCDIR)
	rm -f mkgit.1.gz

uninstall:
	rm -f $(FUNCDIR)/mkgitdir.sh
	rm -f $(MANDIR)/mkgit.1.gz
	rm -rf $(DOCDIR)

# Disable the self-upgrade mechanism entirely. Intended for packagers.
#
# We assume that sed(1) has the -i option, which is not POSIX but seems common
# enough in modern implementations.
disable-self-upgrade:
	sed -i.bak 's/^ENABLE_SELF_UPGRADE_MECHANISM = True$$/ENABLE_SELF_UPGRADE_MECHANISM = False/' googler
