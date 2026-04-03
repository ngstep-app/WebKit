/* WKView for GNUstep MiniBrowser */
#import "WKViewGNUstep.h"
#include <stdbool.h>
#include <WebKit/WKContext.h>
#include <WebKit/WKContextConfigurationRef.h>
#include <WebKit/WKPage.h>
#include <WebKit/WKPageConfigurationRef.h>
#include <WebKit/WKPageNavigationClient.h>
#include <WebKit/WKURL.h>
#include <WebKit/WKString.h>

@implementation WebKitView
{
    WKContextRef _context;
    WKPageConfigurationRef _pageConfig;
    NSString *_currentURL;
    NSString *_statusText;
    BOOL _contextReady;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _statusText = @"Initializing WebKit...";
        _currentURL = @"";
        _contextReady = NO;

        // Create context with configuration
        WKContextConfigurationRef contextConfig = WKContextConfigurationCreate();
        _context = WKContextCreateWithConfiguration(contextConfig);

        if (_context) {
            _pageConfig = WKPageConfigurationCreate();
            WKPageConfigurationSetContext(_pageConfig, _context);
            _contextReady = YES;
            _statusText = @"WebKit context ready.\nEnter a URL and press Return.";
        } else {
            _statusText = @"Failed to create WebKit context.";
        }
    }
    return self;
}

- (void)drawRect:(NSRect)rect
{
    [[NSColor whiteColor] setFill];
    NSRectFill(rect);

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    NSDictionary *attrs = @{
        NSFontAttributeName: [NSFont systemFontOfSize:14],
        NSForegroundColorAttributeName: [NSColor darkGrayColor],
        NSParagraphStyleAttributeName: style
    };

    NSString *display = _currentURL.length > 0
        ? [NSString stringWithFormat:@"%@\n\nURL: %@\n\nWebKit context: %@\nPage config: %@",
            _statusText, _currentURL,
            _context ? @"OK" : @"NULL",
            _pageConfig ? @"OK" : @"NULL"]
        : _statusText;

    NSRect textRect = NSInsetRect(rect, 40, rect.size.height / 3);
    [display drawInRect:textRect withAttributes:attrs];
}

- (void)loadURL:(NSString *)urlString
{
    _currentURL = [urlString copy];

    if (_contextReady) {
        _statusText = [NSString stringWithFormat:@"Loading: %@\n\nWebKit multi-process architecture initialized.\nRendering requires WebView<->PageClient bridge\n(next development step).", urlString];
    } else {
        _statusText = @"WebKit context not ready";
    }
    [self setNeedsDisplay:YES];
}

- (void)loadHTMLString:(NSString *)html
{
    _statusText = @"HTML loaded";
    [self setNeedsDisplay:YES];
}

- (void)goBack { NSLog(@"goBack"); }
- (void)goForward { NSLog(@"goForward"); }
- (void)reload { if (_currentURL) [self loadURL:_currentURL]; }
- (BOOL)acceptsFirstResponder { return YES; }

@end
