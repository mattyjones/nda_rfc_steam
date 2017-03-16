SHELL = /bin/bash

# version 0.0.1
# Copyright (c) 2016 Matt Jones

.PHONY: all build clean pre-build version

vc_file = "./scripts/vc.tex"

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

# Set the path that the tarball will be dropped into.
ifndef targetdir
	targetdir = "./build"
endif

all: clean pre-build build-clean

clean:
	@rm -rf ./build

pre-build: clean 
	@mkdir build

build-clean: clean pre-build build
	@lualatex --enable-write18 --halt-on-error --output-format=pdf --output-directory=./build ./src/main.tex

version:
	@./scripts/vc

read: clean pre-build build-clean 
	@xpdf ./src/main.pdf

