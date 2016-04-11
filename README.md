This is a loose collection of tools that support reproducible
computing using literate programming.

It is *not* a library, and it is *not* a framework; rather, a
description to an approach to computing and documentation, along with
tools that support this approach.

The name, `lir`, stands for **li**terate, **r**eproducible computing.

# Software prerequisites
You need a reasonably modern Linux/BSD operating system.
Any of the major Linux and BSD distributions should fulfil that requirement.
It might be possible to use other operating systems, but do not expect support (sorry).

In particular, you will need an up-to-date version of the GNU Toolchain (`autoconf`, `make`, `GCC`, `binutils`, `glibc`), as well as `bash` along with the standard command line tools like `grep`, `sed`, and `awk` (to name a few).

Furthermore, you need to install the following software:

  - [Noweb](https://www.cs.tufts.edu/~nr/noweb/), "A Simple, Extensible Tool for Literate Programming."
    Available in the Ubuntu official repositories.
    You can also [look at the Debian package](http://packages.debian.org/noweb) or even attempt to [compile it from source](ftp://www.eecs.harvard.edu/pub/nr) (if you do that, make sure you get version 2.11b).

  - [SWI-Prolog](http://www.swi-prolog.org/), a comprehensive free Prolog environment.
    It is easy to [install from source](http://www.swi-prolog.org/git.html), and for Ubuntu, the maintainer [provides a PPA](http://www.swi-prolog.org/build/Debian.txt).
    Just make sure you have the latest development or stable release, and not the very outdated release available in the official repositories of most distributions.

  - [Pandoc](http://pandoc.org/), a universal document converter.
    Installing from source is a bit of a hustle, but you don't have to: just get the installer for the latest release from the [download page on GitHub](https://github.com/jgm/pandoc/releases/tag/1.15.0.6).
    It is important that you have the latest (patched) release, as there have been a non-negative number of bugs in major releases that get in the way.

# Recommended reading

## Makefiles
It would help you if you had some working knowledge of writing makefiles, as understood by GNU Make.
Reading the [official documentation](https://www.gnu.org/software/make/manual/html_node/index.html) is a good start, at least take a look at the first few chapters.
The tutorial (TODO: write a tutorial) should be enough to learn by example.

## Markdown
You need to have a basic idea of the concept of [markdown](https://en.wikipedia.org/wiki/Markdown).
Armed with this knowledge, open the [excellent README provided by Pandoc](http://pandoc.org/README.html) and use it as a reference.

## Literate Programming with `noweb`
Understanding the concept of literate programming is, sadly, a must.
You can take a look at the [original publication by Donald E. Knuth (pdf link)](http://www.literateprogramming.com/knuthweb.pdf).
The [Wikipedia page for `noweb`](https://en.wikipedia.org/wiki/Noweb) contains enough detail to get you acquainted with the syntax.
A `lir` source file is basically a `noweb` source file.

# Installation
Once you have all prerequisites and mad skillz, clone this repository and go to the `lir` directory:

~~~~
$ git clone https://github.com/borisvassilev/lir.git
$ cd lir
~~~~

Then, figure out where you have installed the `noweb` library files.
If you installed from the official Ubuntu directories, this should be `/usr/lib/noweb`.

If you cannot find this directory, the directory where the files were installed is mentioned towards the bottom of the `nowebfilters` man page, under the `FILES` section.
So try this:

~~~~
$ man nowebfilters
~~~~

If for some reason you this doesn't work either, you can try looking for one of the files in the library, for example:

~~~~
$ locate emptydefn
~~~~

If you cannot find a file called `emptydefn` on your system, you have not installed `noweb`.

Now that you know where the library files are, open the file that contains most of the code of the project, `lir.lir`. Somewhere in lines 20-26 there are three path definitions that you might need to change.

On line 22 is the folder where all `lir` components are installed.

On line 24 is the folder where the main `lir` script will be installed; make sure it is on your system `PATH`.

On line 26 is the folder containing the `noweb` library files.
If you installed `noweb` normally (and as root), this will read `/urs/lib/noweb`.

Now save and close the file, and run:

~~~~
$ bash bootstrap
~~~~

You should see a bunch of stuff on your terminal screen, with the bottom line claiming that the "Weaved document is in lir.html".
Look for `lir.html`, and try to open it.
If you see a properly formed HTML page with a whole bunch of code in it, you have successfully installed `lir` and used it to compile that very HTML page you are looking at.

# Acknowledgements
This work is done at the University of Helsinki, Finland by Boris Vassilev and Erkka Valo, under the supervision of Sampsa Hautaniemi and Elina Ikonen.
It is licenced under the terms of the GPL (see COPYING).

Copyright 2015 Boris Vassilev
