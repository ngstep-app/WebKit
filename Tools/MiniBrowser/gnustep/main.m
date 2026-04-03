#import <AppKit/AppKit.h>
#include <stdio.h>
#import "WKViewGNUstep.h"

@interface BrowserDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *_window;
    NSTextField *_urlField;
    WebKitView *_webView;
}
@end

@implementation BrowserDelegate

- (void)applicationWillFinishLaunching_DISABLED:(NSNotification *)n
{
    fprintf(stderr, "=== WILL FINISH LAUNCHING ===\n");
}

- (void)applicationWillFinishLaunching:(NSNotification *)n
{
    fprintf(stderr, "=== DID FINISH LAUNCHING ===\n");

    NSMenu *mainMenu = [[NSMenu alloc] init];
    NSMenu *fileMenu = [[NSMenu alloc] initWithTitle:@"File"];
    [fileMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
    NSMenuItem *fi = [[NSMenuItem alloc] init];
    [fi setSubmenu:fileMenu];
    [mainMenu addItem:fi];
    [NSApp setMainMenu:mainMenu];

    NSRect frame = NSMakeRect(100, 100, 1024, 768);
    _window = [[NSWindow alloc]
        initWithContentRect:frame
        styleMask:(NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskResizable)
        backing:NSBackingStoreBuffered defer:NO];
    [_window setTitle:@"MiniBrowser"];

    CGFloat barY = frame.size.height - 30;
    NSView *cv = [_window contentView];

    _urlField = [[NSTextField alloc] initWithFrame:NSMakeRect(5, barY, frame.size.width-10, 24)];
    [_urlField setStringValue:@"https://example.com"];
    [_urlField setTarget:self];
    [_urlField setAction:@selector(go:)];
    [_urlField setAutoresizingMask:NSViewWidthSizable|NSViewMinYMargin];
    [cv addSubview:_urlField];

    fprintf(stderr, "=== Creating WebKitView ===\n");
    _webView = [[WebKitView alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, barY-2)];
    fprintf(stderr, "=== WebKitView: %p ===\n", _webView);
    [_webView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [cv addSubview:_webView];
    [_window makeKeyAndOrderFront:nil];
    [self go:_urlField];
}

- (void)go:(id)sender
{
    NSString *url = [_urlField stringValue];
    if (![url hasPrefix:@"http://"] && ![url hasPrefix:@"https://"])
        url = [@"https://" stringByAppendingString:url];
    [_urlField setStringValue:url];
    fprintf(stderr, "=== Loading: %s ===\n", [url UTF8String]);
    [_webView loadURL:url];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)a { return YES; }

@end

int main(int argc, char *argv[])
{
    fprintf(stderr, "=== MAIN START ===\n");
    @autoreleasepool {
        [NSApplication sharedApplication];
        BrowserDelegate *d = [[BrowserDelegate alloc] init];
        [NSApp setDelegate:d];
        fprintf(stderr, "=== Delegate set, calling run ===\n");
        [NSApp run];
    }
    return 0;
}
