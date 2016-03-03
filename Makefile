CXXFLAGS = -std=c++14 -O2

langs.cpp: langs.nw
	notangle -t8 -filter emptydefn -R"$@" $< > $@
