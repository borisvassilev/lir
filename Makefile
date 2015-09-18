tangled = \
	lire \
	lire-weave \
	$(bashscripts) \
	$(awkscripts) \
	$(nwpipesources) \
	lire.css

bashscripts = \
	lire-tangle \
	lire-cmpcp \
	lire-mtangle \
	lire-use \
	lire-chunknames 

awkscripts = lire-listing.awk lire-include.awk

nwpipesources = nwpipe-pandoc.pl driver.pl nwpipe.pl lirehtml.pl

all : lire.lir
	$(NOWEB_LIBPATH)/markup -t lire.lir \
	    | $(NOWEB_LIBPATH)/emptydefn \
	    | $(NOWEB_LIBPATH)/mnt -t $(tangled)
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

