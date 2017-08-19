CFLAGS ?= -std=c99 -Wall -Wextra -pedantic

ifeq ($(OS),Windows_NT)
	WEBVIEW_CFLAGS := -DWEBVIEW_WINAPI=1
	WEBVIEW_LDFLAGS := -lole32 -lcomctl32 -loleaut32 -luuid -mwindows
else ifeq ($(shell uname -s),Linux)
	WEBVIEW_CFLAGS := -DWEBVIEW_GTK=1 $(shell pkg-config --cflags gtk+-3.0 webkitgtk-3.0)
	WEBVIEW_LDFLAGS := $(shell pkg-config --libs gtk+-3.0 webkitgtk-3.0)
else ifeq ($(shell uname -s),Darwin)
	WEBVIEW_CFLAGS := -DWEBVIEW_COCOA=1 -x objective-c
	WEBVIEW_LDFLAGS := -framework Cocoa
endif

example: main.c
	$(CC) main.c $(CFLAGS) $(LDFLAGS) $(WEBVIEW_CFLAGS) $(WEBVIEW_LDFLAGS) -o $@