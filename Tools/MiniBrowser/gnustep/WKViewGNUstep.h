#ifndef WKViewGNUstep_h
#define WKViewGNUstep_h

#ifdef __OBJC__
#import <AppKit/AppKit.h>

@interface WebKitView : NSView
- (instancetype)initWithFrame:(NSRect)frame;
- (void)loadURL:(NSString *)urlString;
- (void)loadHTMLString:(NSString *)html;
- (void)goBack;
- (void)goForward;
- (void)reload;
@end

#endif
#endif
