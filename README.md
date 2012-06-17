# NDS Hacking Kit

Welcome to the development branch of the NDS Hacking Kit!

The code is in the ```src``` directory. Check the commit history for the latest
development status and hack away.

## Build Instructions

### Setup

Running one of these will install all of the needed build tools for this
application, depending on your distro:

    sudo apt-get install build-essential libwxgtk2.8-dev

[](/blank)

    sudo yum groupinstall 'Development Tools'
    sudo yum install wxGTK

If you're using Pacman/Portage/whatever, you know enough to be able to find GCC
and wxWidgets on your own.

The NDS Hacking Kit is written in C++ using wxWidgets 2.8.12. If your compiler
is having trouble finding the wxWidgets library and you know that you have it
installed, check that there is output for the following commands:

    wx-config --cxxflags
    wx-config --libs

### Full Build

Run ```make -f client.mk``` to fully build the program, or
```make -f client.mk rebuild``` to completely rebuild the program and all
object files.

Other options:

```make -f client.mk debug``` fully builds the program with debugging symbols
and options, and disables optimization.

```make -f client.mk rebuild-dbg``` rebuilds the program in the debug
configuration.

```make -f client.mk clean``` deletes all object files while leaving the
application intact

```make -f client.mk delete``` or ```make -f client.mk erase``` will completely
delete all build artifacts, including the compiled application.

```make -f client.mk distclean``` will reset the build configuration to
default, but retains your ```.ndsconfig``` if you have one.

### Incremental Builds

Running ```make``` at the top of the source tree will build only the
executable. There is a Makefile in each of the subdirectories as well; running
```make``` in those subdirectories will build only the object files in that
directory (and recurse into their own subdirectories, if applicable). All of
the targets of ```client.mk``` (except for ```delete```, ```erase```, and
```distclean```) are available to these Makefiles as well.

### Build Configuration

To customize your build, create a file named ```.ndsconfig``` to hold your
build options. List the build options in this file, line by line. Lines that
are not valid build options will be ignored, but begin comments with # for the
sake of consistency. The current build options allow you to choose which
pages are to be compiled:

```
add_options --add-button-activator-generator
add_options --add-pointer-searcher
add_options --add-code-porter
add_options --add-code-compressor
```

To apply your selected options to be used next build, run ```./configure```. If
there is no ```.ndsconfig``` or if the file is blank, by default all pages
will be built and included in the application.

