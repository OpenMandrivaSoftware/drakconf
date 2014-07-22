THEMES = default kde gnome
mcc_dir = $(DESTDIR)/usr/share/mcc/themes

all:

clean:

install:
	for d in $(THEMES); do ( install -d $(mcc_dir)/$$d ; install -m644 $$d/*.png $(mcc_dir)/$$d ; if [ -e $$d/*.rc ]; then install -m644 $$d/*.rc $(mcc_dir)/$$d; fi; ) ; done
