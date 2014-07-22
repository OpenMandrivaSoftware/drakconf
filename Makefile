VERSION = 12.19.5
NAME = drakconf
SUBDIRS = po pixmaps #data
localedir = $(DESTDIR)/usr/share/locale
mcc_dir = $(DESTDIR)/usr/share/mcc
SYSCONFDIR = $(DESTDIR)/etc/sysconfig
PERL_VENDORLIB=$(DESTDIR)/$(shell perl -V:installvendorlib   | perl -pi -e "s/.*=//; s/[;']//g")

override CFLAGS += -DPACKAGE=\"$(NAME)\" -DLOCALEDIR=\"$(localedir)\"

%.desktop:   %.desktop.in
	intltool-merge --utf8 po $< $@ -d -u -c intltool-merge-cache

all: drakconf drakconf.desktop
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done

drakconf: 
	cp -l control-center drakconf

clean:
	$(MAKE) -C po $@
	rm -f *~ drakconf core .#*[0-9] core.* *.bak
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done

install: all
	$(MAKE) -C po $@
	install -d $(DESTDIR)/usr/{bin/,share/icons}
	install -d $(DESTDIR)/usr/sbin
	install -d $(mcc_dir)/themes/default/
	install -m644 control-center.rc $(mcc_dir)/themes/default/gtkrc
	install -m755 $(NAME) $(DESTDIR)/usr/sbin/$(NAME).real
	install -m755 wrapper $(DESTDIR)/usr/bin/$(NAME)
	install -m755 menus_launcher.pl $(DESTDIR)/usr/sbin/
	install -m755 print_launcher.pl $(DESTDIR)/usr/sbin/
	install -m755 drakxconf $(DESTDIR)/usr/sbin/
	install -m755 drakconsole $(DESTDIR)/usr/sbin/
	install -m755 mdkwebadmin.pl $(DESTDIR)/usr/bin/
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done
	mkdir -p $(PERL_VENDORLIB)/MDV/
	install -m 644 lib/MDV/*.pm $(PERL_VENDORLIB)/MDV/
	./generate-conf-file.pl
	mkdir -p $(SYSCONFDIR)
	install -m 644 mcc.conf $(SYSCONFDIR)
	install -m 644 progs.conf $(mcc_dir)/

dist:
	git archive --prefix=$(NAME)-$(VERSION)/ HEAD | xz -cv -T0 > $(NAME)-$(VERSION).tar.xz;
dis: clean
	rm -rf $(NAME)-$(VERSION) ../$(NAME)-$(VERSION).tar*
	svn export -q -rBASE . $(NAME)-$(VERSION)
	find $(NAME)-$(VERSION) -name '*.p[lm]' -o -name control-center | xargs perl -pi -e 's/\s*use\s+(diagnostics|vars|strict).*//g'
	tar cJa ../$(NAME)-$(VERSION).tar.xz $(NAME)-$(VERSION)
	rm -rf $(NAME)-$(VERSION)

changelog:
	svn2cl --authors ../common/username.xml --accum
	rm -f ChangeLog.bak


log: changelog
