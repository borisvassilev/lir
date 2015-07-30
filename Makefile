libpath = $(HOME)/lib/lire
binpath = $(HOME)/bin

all : lire
.PHONY : all

lire : lire.lir
	notangle -t8 -R"lire.sh" lire.lir > lire
	chmod u+x lire
	./lire lire.lir

install :
	mkdir --parents $(libpath)
	cp .lire/nwpipe-pandoc $(libpath)
	cp .lire/lire.css $(libpath)
	cp .lire/lire-weave $(libpath)
	chmod u+x $(libpath)/lire-weave
	mkdir --parents $(binpath)
	cp lire $(binpath)/lire

.PHONY : install
clean :
	-rm lire
	rm .lire/*
.PHONY : clean


uninstall :
	-rm -r $(libpath)
	-rm $(binpath)/lire
.PHONY : uninstall

