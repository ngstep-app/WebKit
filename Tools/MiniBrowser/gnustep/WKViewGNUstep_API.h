#ifndef WKViewGNUstep_h
#define WKViewGNUstep_h

#include <WebKit/WKBase.h>
#include <WebKit/WKPageConfigurationRef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct OpaqueWKView* WKViewGNUstepRef;

WK_EXPORT WKViewGNUstepRef WKViewGNUstepCreate(WKPageConfigurationRef configuration);
WK_EXPORT WKPageRef WKViewGNUstepGetPage(WKViewGNUstepRef view);
WK_EXPORT void WKViewGNUstepSetSize(WKViewGNUstepRef view, int width, int height);
WK_EXPORT void WKViewGNUstepDestroy(WKViewGNUstepRef view);

#ifdef __cplusplus
}
#endif

#endif
