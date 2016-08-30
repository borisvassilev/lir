[Lir is a reproducible computing tool](http://borisvassilev.github.io/lir/).
The name Lir stands for **li**terate, **r**eproducible computing.
It is available as [free software](https://github.com/borisvassilev/lir).
It comes with a [User's Guide](http://borisvassilev.github.io/lir/lir.html).

# Prerequisites
You need a reasonably modern Linux/BSD operating system.
Any of the major GNU/Linux and BSD distributions, and OS X fulfil that requirement.
It should be possible to use it on Microsoft Windows 10, but at the moment this is not officially supported: however, if you are interested in trying to install Lir on a Windows 10, share your experience.

In particular, you will need an up-to-date version of the GNU Toolchain (`autoconf`, `make`, `gcc`, `binutils`, `glibc`), as well as Bash along with the standard command line tools like `grep`, `sed`, and `awk` (to name a few).

Furthermore, you need to install the following software:

  - [Noweb](https://www.cs.tufts.edu/~nr/noweb/), "A Simple, Extensible Tool for Literate Programming."
    Available in the Ubuntu official repositories.
    You can also [look at the Debian package](http://packages.debian.org/noweb) or even attempt to [compile it from source](ftp://www.eecs.harvard.edu/pub/nr) (if you do that, make sure you get version 2.11b).

  - [SWI-Prolog](http://www.swi-prolog.org/), a comprehensive free Prolog environment.
    It is easy to [install from source](http://www.swi-prolog.org/git.html), and for Ubuntu, the maintainer [provides a PPA](http://www.swi-prolog.org/build/Debian.txt).
    Just make sure you have the **latest development or stable release**, and not one of the very outdated releases available in the official repositories of most distributions.

  - [Pandoc](http://pandoc.org/), a universal document converter.
    Installing from source is a bit of a hustle, but you don't have to: just get the [installer for the latest release](http://pandoc.org/installing.html).
    It is important that you have the latest (patched) release, as there have been a non-negative number of bugs in major releases that get in the way.

# Recommended reading
Lir makes use of existing tools for literate programming, making, and markup.
A working knowledge of these tools is not required, but it is beneficial, at least at the beginning.

## Makefiles
It would help you if you had some working knowledge of writing makefiles, as understood by GNU Make.
Reading the [official documentation](https://www.gnu.org/software/make/manual/html_node/index.html) is a good start; at least take a look at the first few chapters.

## Markdown
You need to have a basic idea of the concept of [markdown](https://en.wikipedia.org/wiki/Markdown).
Armed with this knowledge, open the [excellent manual provided by Pandoc](http://pandoc.org/README.html) and use it as a reference.

## Literate Programming with `noweb`
Understanding the concept of literate programming is, sadly, a must.
You can take a look at the [original publication by Donald E. Knuth (pdf link)](http://www.literateprogramming.com/knuthweb.pdf); you can also skip this at first.
The [Wikipedia page for `noweb`](https://en.wikipedia.org/wiki/Noweb) contains enough detail to get you acquainted with the syntax.
A Lir source file is a valid `noweb` source file.

# Installation
Once you have all prerequisites, clone this repository and go to the `lir` directory:

~~~~
$ git clone https://github.com/borisvassilev/lir.git
$ cd lir
~~~~

Now open the source file, `lir.lir`, and start reading it. At the very top, there are instructions on how to set the paths for your installation and install Lir.
Follow those instructions.
The file is also [available on the web](http://borisvassilev.github.io/lir/lir.html).

To validate the installation, try to compile the `lir.lir` source file, using Lir:

~~~~
$ lir lir.lir
~~~~

Look for `lir.html`, and open it in a web browser.
If you see the Lir User Guide, followed by a whole bunch of code, you have successfully installed Lir and used it to generate its documentation from its source.

# Quick start
This is a minimal example of applying Lir to obtain a result and display it in your final document.

This is the complete Lir source file, named `show-size.lir`, and [available here](https://raw.githubusercontent.com/borisvassilev/lir/master/show-size/show-size.lir):

~~~~
This is a minimal example of how to use Lir.  Here, we will use
the command line tool `wc` (**w**ord **c**ount) to count the
lines, words, and characters in this Lir source file.  We will
display the output in the final document.

We start by declaring a placeholder in a code chunk:
<<:listing size>>=
title: Line, word, and character count
caption: The output of `wc`, when applied to this Lir source file.
@
The name of the code chunk defined above is the string "`:listing
size`".  The prefix, "`:listing`", tells Lir that this is a
placeholder for a file that should be displayed verbatim, as a
listing.  The prefix is followed by a single space character and
the name of the file that should be displayed, "`size`".  Inside
this code chunk, we have defined a title and a caption for the
display item.

The file will be generated by running the command `wc` on this
source file (`show-size.lir`), and saving the output to `size`:
<<:make Generate the file `size`>>=
size: show-size.lir
	wc show-size.lir > size

@
The name of this code chunk has the prefix "`:make `".  This
prefix tells Lir that the code chunk contains a rule, in Make
syntax.  This particular rule reads:

> The file `size` should be generated.  It depends on the file
> `show-size.lir`.  To generate it, run the command `wc` with a
> single argument, `show-size.lir`, and put the output of that
> command in the file `size`.

**NB**: in the rule above, there must be a single tab character
at the beginning of the second line!

Normally, input files have to be declared as "sources" to the
data analysis.  This can be done using the following declaration,
again in a code chunk:
<<:source show-size.lir>>=
@

To use Lir to interpret this source file, you can invoke `lir`
with the filename as the only argument:
<<: Use Lir to interpret this source file>>=
$ lir show-size.lir
@
(This last code chunk has a name that begins with a colon, "`:`",
followed by a space.  This will be ignored when interpreting the
source file, but it will show up in the final document.)

An HTML document named `show-size.html` will be generated in the
same directory.  Open it with your web browser!
~~~~

Generate the final document and open it in your web browser ([here is what I get](http://borisvassilev.github.io/lir/show-size.html)).
Look around.
If you like what you see, you should go on by reading the [Tutorial](https://github.com/borisvassilev/lir-tutorial) for a somewhat longer introduction.

# Acknowledgements
This work is done at the University of Helsinki, Finland by Boris Vassilev and Erkka Valo, under the supervision of Sampsa Hautaniemi and Elina Ikonen.
It is licenced under the terms of the GPL (see COPYING).

Copyright 2015 Boris Vassilev
