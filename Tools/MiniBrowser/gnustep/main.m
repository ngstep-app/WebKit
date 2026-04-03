/* MiniBrowser for GNUstep - WebKit Port */
#import <AppKit/AppKit.h>
#import "WKViewGNUstep.h"

@interface BrowserDelegate : NSObject
{
    NSWindow *_window;
    NSTextField *_urlField;
    WebKitView *_webView;
}
@end

@implementation BrowserDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    // Menu
    NSMenu *mainMenu = [[NSMenu alloc] init];
    NSMenu *fileMenu = [[NSMenu alloc] initWithTitle:@"File"];
    [fileMenu addItemWithTitle:@"Open Location" action:@selector(openLocation:) keyEquivalent:@"l"];
    [fileMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
    NSMenuItem *fileItem = [[NSMenuItem alloc] init];
    [fileItem setSubmenu:fileMenu];
    [mainMenu addItem:fileItem];
    [NSApp setMainMenu:mainMenu];

    // Window
    NSRect frame = NSMakeRect(100, 100, 1024, 768);
    _window = [[NSWindow alloc]
        initWithContentRect:frame
        styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                   NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable)
        backing:NSBackingStoreBuffered
        defer:NO];
    [_window setTitle:@"MiniBrowser"];
    [_window setMinSize:NSMakeSize(400, 300)];
    NSView *content = [_window contentView];

    // Navigation bar
    CGFloat barY = frame.size.height - 30;
    NSButton *back = [[NSButton alloc] initWithFrame:NSMakeRect(5, barY, 30, 24)];
    [back setTitle:@"\xe2\x97\x80"]; // left arrow
    [back setTarget:self]; [back setAction:@selector(goBack:)];
    [back setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
    [content addSubview:back];

    NSButton *fwd = [[NSButton alloc] initWithFrame:NSMakeRect(38, barY, 30, 24)];
    [fwd setTitle:@"\xe2\x96\xb6"]; // right arrow
    [fwd setTarget:self]; [fwd setAction:@selector(goForward:)];
    [fwd setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
    [content addSubview:fwd];

    NSButton *rel = [[NSButton alloc] initWithFrame:NSMakeRect(71, barY, 30, 24)];
    [rel setTitle:@"\xe2\x9f\xb3"]; // reload
    [rel setTarget:self]; [rel setAction:@selector(reload:)];
    [rel setAutoresizingMask:NSViewMaxXMargin | NSViewMinYMargin];
    [content addSubview:rel];

    _urlField = [[NSTextField alloc] initWithFrame:NSMakeRect(105, barY, frame.size.width - 115, 24)];
    [_urlField setStringValue:@"https://example.com"];
    [_urlField setTarget:self]; [_urlField setAction:@selector(navigate:)];
    [_urlField setAutoresizingMask:NSViewWidthSizable | NSViewMinYMargin];
    [content addSubview:_urlField];

    // Web view
    _webView = [[WebKitView alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, barY - 2)];
    [_webView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [content addSubview:_webView];

    [_window makeKeyAndOrderFront:nil];
    [self navigate:_urlField];
}

- (void)navigate:(id)sender
{
    NSString *url = [_urlField stringValue];
    if (![url hasPrefix:@"http://"] && ![url hasPrefix:@"https://"])
        url = [@"https://" stringByAppendingString:url];
    [_urlField setStringValue:url];
    [_window setTitle:[NSString stringWithFormat:@"%@ - MiniBrowser", url]];
    [_webView loadURL:url];
}

- (void)goBack:(id)sender { [_webView goBack]; }
- (void)goForward:(id)sender { [_webView goForward]; }
- (void)reload:(id)sender { [_webView reload]; }
- (void)openLocation:(id)sender { [_window makeFirstResponder:_urlField]; }

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app { return YES; }

@end

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [NSApplication sharedApplication];
        BrowserDelegate *d = [[BrowserDelegate alloc] init];
        [NSApp setDelegate:(id)d];
        [NSApp run];
    }
    return 0;
}
