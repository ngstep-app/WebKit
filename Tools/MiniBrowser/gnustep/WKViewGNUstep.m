/* WKView for GNUstep MiniBrowser */
#import "WKViewGNUstep.h"
#include <stdbool.h>
#include <stdio.h>
#include <WebKit/WKContext.h>
#include <WebKit/WKContextConfigurationRef.h>
#include <WebKit/WKPage.h>
#include <WebKit/WKPageConfigurationRef.h>
#include <WebKit/WKURL.h>
#include <WebKit/WKString.h>

typedef struct OpaqueWKView* WKViewGNUstepRef;
extern WKViewGNUstepRef WKViewGNUstepCreate(WKPageConfigurationRef configuration);
extern WKPageRef WKViewGNUstepGetPage(WKViewGNUstepRef view);
extern void WKViewGNUstepSetSize(WKViewGNUstepRef view, int width, int height);
extern int WKViewGNUstepPaint(WKViewGNUstepRef view, unsigned char* buffer, int width, int height, int stride);
extern void WKViewGNUstepDestroy(WKViewGNUstepRef view);

@implementation WebKitView
{
    WKContextRef _context;
    WKPageConfigurationRef _pageConfig;
    WKViewGNUstepRef _wkView;
    WKPageRef _page;
    NSString *_currentURL;
    NSBitmapImageRep *_bitmap;
    NSTimer *_refreshTimer;
    int _paintCount;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentURL = @"";
        _paintCount = 0;

        WKContextConfigurationRef ctxConfig = WKContextConfigurationCreate();
        _context = WKContextCreateWithConfiguration(ctxConfig);
        if (!_context) return self;

        _pageConfig = WKPageConfigurationCreate();
        WKPageConfigurationSetContext(_pageConfig, _context);

        _wkView = WKViewGNUstepCreate(_pageConfig);
        if (_wkView) {
            _page = WKViewGNUstepGetPage(_wkView);
            WKViewGNUstepSetSize(_wkView, (int)frame.size.width, (int)frame.size.height);
            NSLog(@"WebKitView: page=%p created", _page);
        }

        _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
            target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)tick:(NSTimer *)t { [self setNeedsDisplay:YES]; }

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect bounds = [self bounds];
    int w = (int)bounds.size.width;
    int h = (int)bounds.size.height;
    if (w <= 0 || h <= 0) return;

    BOOL painted = NO;
    if (_wkView && _page) {
        int stride = w * 4;
        if (!_bitmap || [_bitmap pixelsWide] != w || [_bitmap pixelsHigh] != h) {
            _bitmap = [[NSBitmapImageRep alloc]
                initWithBitmapDataPlanes:NULL pixelsWide:w pixelsHigh:h
                bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO
                colorSpaceName:NSDeviceRGBColorSpace bytesPerRow:stride bitsPerPixel:32];
        }

        unsigned char *px = [_bitmap bitmapData];
        int result = WKViewGNUstepPaint(_wkView, px, w, h, stride);
        _paintCount++;

        if (result) {
            // Save first successful paint to file
            if (_paintCount <= 5) {
                FILE *f = fopen("/tmp/webkit-pixels.raw", "wb");
                if (f) { fwrite(px, 1, stride * h, f); fclose(f); }
                NSLog(@"Paint #%d: success, saved %dx%d pixels", _paintCount, w, h);
            }
            [_bitmap drawInRect:bounds];
            painted = YES;
        }
    }

    if (!painted) {
        [[NSColor whiteColor] setFill];
        NSRectFill(bounds);
        NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
        [ps setAlignment:NSTextAlignmentCenter];
        NSDictionary *a = @{NSFontAttributeName:[NSFont systemFontOfSize:14],
            NSForegroundColorAttributeName:[NSColor grayColor], NSParagraphStyleAttributeName:ps};
        NSString *s = [NSString stringWithFormat:@"WebKit GNUstep\n%@\nPaint attempts: %d",
            _currentURL, _paintCount];
        [s drawInRect:NSInsetRect(bounds, 40, bounds.size.height/3) withAttributes:a];
    }
}

- (void)loadURL:(NSString *)url
{
    _currentURL = [url copy];
    if (_page) {
        NSLog(@"loadURL: %@", url);
        WKURLRef wkurl = WKURLCreateWithUTF8CString([url UTF8String]);
        WKPageLoadURL(_page, wkurl);
    }
    [self setNeedsDisplay:YES];
}

- (void)loadHTMLString:(NSString *)html
{
    if (_page) {
        WKStringRef s = WKStringCreateWithUTF8CString([html UTF8String]);
        WKURLRef base = WKURLCreateWithUTF8CString("about:blank");
        WKPageLoadHTMLString(_page, s, base);
    }
    [self setNeedsDisplay:YES];
}

- (void)goBack { if (_page) WKPageGoBack(_page); }
- (void)goForward { if (_page) WKPageGoForward(_page); }
- (void)reload { if (_page) WKPageReload(_page); }
- (BOOL)acceptsFirstResponder { return YES; }

- (void)setFrameSize:(NSSize)sz
{
    [super setFrameSize:sz];
    _bitmap = nil;
    if (_wkView) WKViewGNUstepSetSize(_wkView, (int)sz.width, (int)sz.height);
}

@end
