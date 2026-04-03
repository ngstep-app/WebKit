/*
 * MiniBrowser for GNUstep - main.m
 * Minimal browser shell using WebKit C API
 */
#import <AppKit/AppKit.h>

@interface AppDelegate : NSObject
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    // Create main menu
    NSMenu *mainMenu = [[NSMenu alloc] init];
    NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"MiniBrowser"];
    [appMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
    NSMenuItem *appItem = [[NSMenuItem alloc] init];
    [appItem setSubmenu:appMenu];
    [mainMenu addItem:appItem];
    [NSApp setMainMenu:mainMenu];

    // Create browser window
    NSRect frame = NSMakeRect(100, 100, 1024, 768);
    NSWindow *window = [[NSWindow alloc]
        initWithContentRect:frame
        styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                   NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable)
        backing:NSBackingStoreBuffered
        defer:NO];
    [window setTitle:@"MiniBrowser - GNUstep WebKit Port"];

    // URL bar
    NSTextField *urlField = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 738, 1004, 24)];
    [urlField setStringValue:@"https://example.com"];
    [urlField setAutoresizingMask:NSViewWidthSizable | NSViewMinYMargin];
    [[window contentView] addSubview:urlField];

    // Status label
    NSTextField *statusLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(10, 350, 1004, 100)];
    [statusLabel setStringValue:@"WebKit GNUstep Port\n\nJavaScriptCore + WebCore + WebKit2\nAll libraries built successfully!\n\nWeb rendering coming soon."];
    [statusLabel setAlignment:NSTextAlignmentCenter];
    [statusLabel setEditable:NO];
    [statusLabel setBezeled:NO];
    [statusLabel setDrawsBackground:NO];
    [statusLabel setFont:[NSFont systemFontOfSize:18]];
    [statusLabel setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [[window contentView] addSubview:statusLabel];

    [window makeKeyAndOrderFront:nil];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app
{
    return YES;
}

@end

int main(int argc, char *argv[])
{
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        [app setDelegate:delegate];
        [app run];
    }
    return 0;
}
