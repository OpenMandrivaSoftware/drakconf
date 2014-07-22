# Installation directories
top_srcdir=..
localedir = $(DESTDIR)/usr/share/locale

PGOAL = drakconf

# perl files to search translatable strings in
PL_FILES = ../contributors.pl ../control-center ../drakconsole ../drakxconf \
	   ../menus_launcher.pl ../print_launcher.pl ../lib/MDV/Control_Center.pm
# C-like files to search translatable strings in
#CFILES = 

POFILES = $(shell ls *.po)
MOFILES = $(POFILES:%.po=%.mo)
LANGS = $(POFILES:%.po=%)

PREFIX = $(RPM_BUILD_ROOT)/usr
DATADIR = $(PREFIX)/share
LOCALEDIR=$(DATADIR)/locale

GOALS = $(PGOAL).pot $(MOFILES)

all: $(GOALS)

install: all
	for l in $(LANGS); do \
		install -d $(localedir)/$$l/LC_MESSAGES; \
		install -m 644 $$l.mo $(localedir)/$$l/LC_MESSAGES/$(PGOAL).mo; \
	done

clean:
	rm -f *~ *.[oas] *.mo $(MOFILES) TAGS $(PL_CFILES)

%.mo: %.po
	msgfmt -o $@ $<

POTFILES.in:
	(cd .. ; /bin/ls data/*.desktop.in data/*.directory.in *.desktop.in) > POTFILES.in

$(PGOAL).pot: $(PL_FILES) POTFILES.in
	intltool-update --gettext-package desktopstuff --pot
	perl_checker -q --generate-pot $(PGOAL)_tmp.pot $(PL_FILES)
	msgcat --use-first $(PGOAL)_tmp.pot desktopstuff.pot > $@
	rm -f desktopstuff.pot $(PGOAL)_tmp.pot

update_n_merge: $(PGOAL).pot merge

merge:
	@for n in $(POFILES); do \
		echo "Merging $$n"; \
		msgmerge -C "$$n" "$$n" $(PGOAL).pot > "$$n"t; \
		mv -f "$$n"t "$$n"; \
	done

