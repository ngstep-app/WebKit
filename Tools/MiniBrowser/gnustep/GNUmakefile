include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = MiniBrowser
BUILD_DIR = ../../../build-gnustep

MiniBrowser_OBJC_FILES = main.m WKViewGNUstep.m

MiniBrowser_OBJCFLAGS = -fobjc-arc -fobjc-runtime=gnustep-2.2 -fblocks -include stdbool.h
MiniBrowser_INCLUDE_DIRS = -I$(BUILD_DIR)/WebKit/Headers -I$(BUILD_DIR)/WebKit/Headers/WebKit
MiniBrowser_LIB_DIRS = -L$(BUILD_DIR)/lib
MiniBrowser_LDFLAGS = -Wl,-rpath,$(BUILD_DIR)/lib -Wl,--unresolved-symbols=ignore-in-shared-libs
MiniBrowser_OBJC_LIBS = -lWebKit2 -lWebCore -lJavaScriptCore
MiniBrowser_RESOURCE_FILES = Resources/Info.plist

include $(GNUSTEP_MAKEFILES)/application.make
