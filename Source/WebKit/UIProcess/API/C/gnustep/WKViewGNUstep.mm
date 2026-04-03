#include "config.h"
#import "WKViewGNUstep.h"

#import <AppKit/AppKit.h>
#import <WebKit/WKContext.h>
#import <WebKit/WKPage.h>
#import <WebKit/WKPageConfigurationRef.h>
#import <WebKit/WKPageNavigationClient.h>
#import <WebKit/WKURL.h>

// WebKitView - NSView subclass for rendering web content
@interface WebKitView : NSView
{
    WKContextRef _context;
    WKPageRef _page;
}
- (void)loadURL:(NSString *)urlString;
- (WKPageRef)page;
@end

@implementation WebKitView

- (instancetype)initWithFrame:(NSRect)frame configuration:(WKPageConfigurationRef)config
{
    self = [super initWithFrame:frame];
    if (self) {
        // Create context and page
        _context = WKPageConfigurationGetContext(config);
        // TODO: Create page with proper configuration
        // This requires deeper WebKit2 integration
        NSLog(@"WebKitView created with frame: %@", NSStringFromRect(frame));
    }
    return self;
}

- (void)drawRect:(NSRect)rect
{
    // Draw placeholder for now
    [[NSColor whiteColor] setFill];
    NSRectFill(rect);

    NSDictionary *attrs = @{
        NSFontAttributeName: [NSFont systemFontOfSize:14],
        NSForegroundColorAttributeName: [NSColor darkGrayColor]
    };
    NSString *msg = @"WebKit GNUstep - Web content area\n(Rendering pipeline not yet connected)";
    NSSize textSize = [msg sizeWithAttributes:attrs];
    NSPoint point = NSMakePoint(
        (rect.size.width - textSize.width) / 2,
        (rect.size.height - textSize.height) / 2);
    [msg drawAtPoint:point withAttributes:attrs];
}

- (void)loadURL:(NSString *)urlString
{
    NSLog(@"WebKitView: loadURL: %@", urlString);
    // TODO: Wire to WKPageLoadURL when page is properly initialized
}

- (WKPageRef)page
{
    return _page;
}

- (BOOL)acceptsFirstResponder { return YES; }

- (void)mouseDown:(NSEvent *)event
{
    NSLog(@"WebKitView: mouseDown at %@", NSStringFromPoint([event locationInWindow]));
}

- (void)keyDown:(NSEvent *)event
{
    NSLog(@"WebKitView: keyDown: %@", [event characters]);
}

@end

// C API implementation
struct OpaqueWKView {
    WebKitView* nsView;
    WKPageConfigurationRef config;
};

WKViewRef WKViewCreateForGNUstep(WKPageConfigurationRef configuration)
{
    WKViewRef view = (WKViewRef)calloc(1, sizeof(struct OpaqueWKView));
    view->config = configuration;
    view->nsView = [[WebKitView alloc] initWithFrame:NSMakeRect(0, 0, 800, 600)
                                       configuration:configuration];
    return view;
}

WKPageRef WKViewGetPage(WKViewRef view)
{
    return view ? [view->nsView page] : NULL;
}

void WKViewSetSize(WKViewRef view, int width, int height)
{
    if (view && view->nsView) {
        [view->nsView setFrameSize:NSMakeSize(width, height)];
    }
}

void WKViewLoadURL(WKViewRef view, const char* url)
{
    if (view && view->nsView && url) {
        [view->nsView loadURL:[NSString stringWithUTF8String:url]];
    }
}

NSView* WKViewGetNSView(WKViewRef view)
{
    return view ? view->nsView : nil;
}
