binpath = $(LIRE_BINPATH)
libpath = $(LIRE_LIBPATH)
noweblibpath = $(NOWEB_LIBPATH)

tangled = \
	$(scripts) \
	$(nwpipesources) \
	lire.css

scripts = \
	lire \
	lire-weave \
	$(bashscripts) \
	$(awkscripts)

bashscripts = \
	lire-tangle \
	lire-cmpcp \
	lire-mtangle \
	lire-use \
	lire-chunknames 

awkscripts = lire-listing.awk lire-include.awk

nwpipesources = nwpipe-pandoc.pl driver.pl nwpipe.pl lirehtml.pl

all : $(tangled) nwpipe-pandoc
.PHONY : all

$(tangled) : lire.lir
	$(noweblibpath)/markup -t lire.lir \
	    | $(noweblibpath)/emptydefn \
	    | $(noweblibpath)/mnt -t $(tangled)

nwpipe-pandoc : $(nwpipesources)
	swipl --goal=main -o nwpipe-pandoc -c nwpipe-pandoc.pl

clean :
	-rm $(tangled) nwpipe-pandoc
.PHONY : clean

