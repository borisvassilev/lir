bashscripts = \
	lir-cmpcp \
	lir-use

nwpipemodules = driver.pl nwpipe.pl lirhtml.pl

nwpipesources = nwpipe-pandoc.pl $(nwpipemodules)

tangled = \
	lir \
	lir-weave \
	$(bashscripts) \
	$(nwpipesources) \
	lir.css

all : lir.lir
	$(NOWEB_LIBPATH)/markup -t lir.lir \
	    | $(NOWEB_LIBPATH)/emptydefn \
	    | $(NOWEB_LIBPATH)/mnt -t $(tangled)
	sed -i "s~@@LIR_LIBPATH@@~$(LIR_LIBPATH)~" lir lir-weave
	sed -i "s~@@NOWEB_LIBPATH@@~$(NOWEB_LIBPATH)~" lir lir-weave
	swipl --goal=main -o nwpipe-pandoc -c nwpipe-pandoc.pl
	chmod u+x lir lir-weave $(bashscripts)
.PHONY : all

install :
	cp --verbose --preserve \
	    $(bashscripts) \
	    lir.css \
	    nwpipe-pandoc \
	    	$(LIR_LIBPATH)
	cp --verbose --preserve \
	    lir lir-weave $(LIR_BINPATH)
.PHONY : install

clean :
	-rm $(tangled) nwpipe-pandoc
.PHONY : clean

