bashscripts = \
	lire-tangle \
	lire-cmpcp \
	lire-mtangle \
	lire-use \
	lire-chunknames 

awkscripts = lire-listing.awk

nwpipemodules = driver.pl nwpipe.pl lirehtml.pl

nwpipesources = nwpipe-pandoc.pl $(nwpipemodules)

tangled = \
	lire \
	lire-weave \
	$(bashscripts) \
	$(awkscripts) \
	$(nwpipesources) \
	noweb-args.cpp \
	lire.css

all : lire.lir
	$(NOWEB_LIBPATH)/markup -t lire.lir \
	    | $(NOWEB_LIBPATH)/emptydefn \
	    | $(NOWEB_LIBPATH)/mnt -t $(tangled)
	$(MAKE) noweb-args
	$(MAKE) nwpipe-pandoc
	sed -i "s~@@LIRE_LIBPATH@@~$(LIRE_LIBPATH)~" lire lire-weave
	sed -i "s~@@NOWEB_LIBPATH@@~$(NOWEB_LIBPATH)~" lire lire-weave
	swipl --goal=main -o nwpipe-pandoc -c nwpipe-pandoc.pl
	chmod u+x lire lire-weave $(bashscripts)
.PHONY : all

install :
	cp --verbose --preserve \
	    $(bashscripts) \
	    $(awkscripts) \
	    lire.css \
	    nwpipe-pandoc \
	    	$(LIRE_LIBPATH)
	cp --verbose --preserve \
	    lire lire-weave $(LIRE_BINPATH)
.PHONY : install

clean :
	-rm $(tangled) nwpipe-pandoc
.PHONY : clean

