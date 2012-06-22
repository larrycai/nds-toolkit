# -*- makefile -*-
# vim:set ts=8 sw=8 noet:

# NDS Hacking Kit - A suite of tools for hacking Nintendo video games.
# Copyright (C) 2012 Vinny Diehl
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# @file client.mk - Contains instructions for building the application.
#
# make
# Builds application.
#
# make debug
# Builds application with debugging symbols and DEBUG defined.
#
# make rebuild
# Rebuilds the application, including all object files.
#
# make rebuild-dbg
# Rebuilds the application, including all object files, to the debug target.
#
# make clean
# Deletes the object files.
#
# make distclean
# Removes all configurations options and resets to default.
# Run this before committing unless you have a good reason not to.
#
# make erase
# make delete
# Deletes the build directory and all files within.

# The following section is generated by the configuration script. Do not
# edit its contents unless you know what you're doing, and do not edit the
# designators surrounding it or the configuration script will break.
### BEGIN CONFIG ###
SETUP = default
### END CONFIG ###

# Parse preset config setups. Note that if the page is to be included,
# the name of the object file is placed into the variable; if it is to be
# excluded, it will be left blank. OBJS will read all of these, and
# only the ones selected for inclusion will be compiled.
ifeq ($(SETUP),default)
    BUTTON_ACTIVATOR_GENERATOR = pgButtonActivatorGenerator.o
    POINTER_SEARCHER = pgPointerSearcher.o
    CODE_PORTER = pgCodePorter.o
    CODE_COMPRESSOR = pgCodeCompressor.o
endif

# Tell pages/Makefile to enforce the configuration. That Makefile requires
# this enforcement so that it can still be built incrementally.
PAGESMAKEVARS = ENFORCE_CONFIG=1 \
		BUTTON_ACTIVATOR_GENERATOR=$(BUTTON_ACTIVATOR_GENERATOR) \
		POINTER_SEARCHER=$(POINTER_SEARCHER) \
		CODE_PORTER=$(CODE_PORTER) \
		CODE_COMPRESSOR=$(CODE_COMPRESSOR)

# Root Source Directory
ROOT = .

# Output Name
NAME = NDSHackingKit
ALTNAME = ndshackingkit

# Output Directories
BUILDROOT = $(ROOT)/build
BINDIR = $(BUILDROOT)/bin
OBJDIR = $(BUILDROOT)/obj
INSTALL = /usr/bin

# Output Files
EXE = $(BINDIR)/$(NAME)
OBJ = Program.o frmMain.o MenuBar.o \
      Clipboard.o FileHandler.o $(BUTTON_ACTIVATOR_GENERATOR) \
      $(POINTER_SEARCHER) $(CODE_PORTER) $(CODE_COMPRESSOR) EBuilder.o
OPATHS = $(addprefix $(OBJDIR)/,$(OBJ))

# Make
MAKE = make
MAKETGT =

.PHONY: all debug distclean configure clean \
	rebuild rebuild-dbg erase delete

all: CFLAGS += -O2
all: configure
all: $(EXE)

debug: CFLAGS += $(DEBUG)
debug: MAKETGT += debug
debug: configure
debug: $(EXE)

configure:
	mkdir -p $(OBJDIR)

$(EXE): $(OPATHS)
	$(MAKE) $(MAKETGT)

### Object Builds

# app

$(OBJDIR)/Program.o:
	$(MAKE) -C app $(MAKETGT)

# frames

$(OBJDIR)/frmMain.o:
	$(MAKE) -C frames $(MAKETGT)

# base

$(OBJDIR)/MenuBar.o:
	$(MAKE) -C base $(MAKETGT)

# pages

$(OBJDIR)/pgButtonActivatorGenerator.o:
	$(MAKE) -C pages $(MAKETGT) $(PAGESMAKEVARS)

$(OBJDIR)/pgCodeCompressor.o:
	$(MAKE) -C pages $(MAKETGT) $(PAGESMAKEVARS)

$(OBJDIR)/EBuilder.o:
	$(MAKE) -C pages $(MAKETGT) $(PAGESMAKEVARS)

$(OBJDIR)/pgCodePorter.o:
	$(MAKE) -C pages $(MAKETGT) $(PAGESMAKEVARS)

$(OBJDIR)/pgPointerSearcher.o:
	$(MAKE) -C pages $(MAKETGT) $(PAGESMAKEVARS)

# clipboard

$(OBJDIR)/Clipboard.o:
	$(MAKE) -C clipboard $(MAKETGT)

# filehandler

$(OBJDIR)/FileHandler.o:
	$(MAKE) -C filehandler $(MAKETGT)

### End Object Builds

clean:
	mkdir -p $(OBJDIR) && rm -r $(OBJDIR)

distclean:
	touch .ndsconfig && mv .ndsconfig .ndsconfig.tmp
	./configure
	mv .ndsconfig.tmp .ndsconfig

rebuild: clean
rebuild: $(EXE)

rebuild-dbg: clean
rebuild-dbg: debug

erase: delete
delete:
	mkdir -p $(BUILDROOT) && rm -r $(BUILDROOT)

install:
	cp $(EXE) $(INSTALL)
	ln -s $(INSTALL)/$(NAME) $(INSTALL)/$(ALTNAME)

