#ifndef WKViewGNUstep_h
#define WKViewGNUstep_h

#include <WebKit/WKBase.h>
#include <WebKit/WKPageConfigurationRef.h>

#ifdef __OBJC__
#import <AppKit/AppKit.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef struct OpaqueWKView* WKViewRef;

WK_EXPORT WKViewRef WKViewCreateForGNUstep(WKPageConfigurationRef configuration);
WK_EXPORT WKPageRef WKViewGetPage(WKViewRef view);
WK_EXPORT void WKViewSetSize(WKViewRef view, int width, int height);
WK_EXPORT void WKViewLoadURL(WKViewRef view, const char* url);

#ifdef __OBJC__
WK_EXPORT NSView* WKViewGetNSView(WKViewRef view);
#endif

#ifdef __cplusplus
}
#endif

#endif /* WKViewGNUstep_h */
