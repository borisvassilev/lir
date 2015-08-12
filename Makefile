libpath = $(HOME)/lib/lire
binpath = $(HOME)/bin

all : lire
.PHONY : all

lire : lire.lir
	notangle -t -R"lire.sh" lire.lir > lire
	chmod u+x lire
	notangle -t -R"lire-mnt.sh" lire.lir > lire-mnt
	chmod u+x lire-mnt
	cp lire-mnt $(libpath)
	./lire lire.lir
	cp lire $(binpath)/lire
	mkdir --parents $(libpath)
	cp .lire/nwpipe-pandoc $(libpath)
	cp .lire/lire.css $(libpath)
	cp .lire/lire-weave $(libpath)
	chmod u+x $(libpath)/lire-weave
	cp .lire/input2lire.awk $(libpath)
	chmod u+x $(libpath)/input2lire.awk
	mkdir --parents $(binpath)

clean :
	-rm lire lire-mnt
	rm .lire/*
.PHONY : clean


uninstall :
	-rm -r $(libpath)
	-rm $(binpath)/lire
.PHONY : uninstall

