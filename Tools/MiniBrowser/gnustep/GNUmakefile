include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = MiniBrowser

MiniBrowser_OBJC_FILES = \
    main.m \
    AppDelegate.m \
    BrowserWindowController.m \
    WK2BrowserWindowController.m \
    SettingsController.m \
    HistoryButton.m

MiniBrowser_OBJCFLAGS = -fobjc-arc
MiniBrowser_INCLUDE_DIRS = -I$(WEBKIT_BUILD_DIR)/Headers
MiniBrowser_LIB_DIRS = -L$(WEBKIT_BUILD_DIR)/lib
MiniBrowser_OBJC_LIBS = -lWebKit -lJavaScriptCore
MiniBrowser_RESOURCE_FILES = Resources/Info.plist

include $(GNUSTEP_MAKEFILES)/application.make
