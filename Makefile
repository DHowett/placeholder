PWD:=$(shell pwd)
TOP_DIR:=$(PWD)
FRAMEWORKDIR=$(TOP_DIR)/framework

TARGET=arm-apple-darwin9
SDKPREFIX=/opt/iphone-sdk-3.0/prefix/bin
PREFIX:=$(SDKPREFIX)/$(TARGET)-

CC=$(PREFIX)gcc
CXX=$(PREFIX)g++
STRIP=$(PREFIX)strip
CODESIGN_ALLOCATE=$(PREFIX)codesign_allocate
export CC CXX STRIP CODESIGN_ALLOCATE

LDFLAGS:=-lobjc -framework Foundation -framework UIKit -framework CoreFoundation \
	-multiply_defined suppress -dynamiclib -init _DownloaderInitialize -Wall \
	-Werror -lsubstrate -lobjc -ObjC++ -fobjc-exceptions -fobjc-call-cxx-cdtors $(LDFLAGS)

ifdef DEBUG
DEBUG_CFLAGS=-DDEBUG -ggdb
STRIP=/bin/true
endif

CFLAGS:=-include Downloader_Prefix.pch -Os -mthumb $(DEBUG_CFLAGS) -I$(FRAMEWORKDIR)/include -I./YouTubeApp -I./YouTube
export FRAMEWORKDIR
export CFLAGS

OFILES=Downloader.o DownloadManager.o DownloadOperation.o SafariDownload.o

TARGET=Downloader.dylib

all: build/$(TARGET)
	@(for i in $(subdirs); do $(MAKE) -C $$i $@; done)

build/$(TARGET): $(OFILES:%.o=build/%.o)
	$(CXX) $(LDFLAGS) -o $@ $^
	$(STRIP) -x $@
	CODESIGN_ALLOCATE=$(CODESIGN_ALLOCATE) ldid -S $@

build/%.o: %.mm
	$(CXX) -c $(CFLAGS) $< -o $@

build/%.o: %.m
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -f build/*
	@(for i in $(subdirs); do $(MAKE) -C $$i $@; done)

package-local: build/$(TARGET)
	cp build/$(TARGET) _/Library/MobileSubstrate/DynamicLibraries
	chown 0.80 _ -R

include $(FRAMEWORKDIR)/makefiles/DebMakefile
