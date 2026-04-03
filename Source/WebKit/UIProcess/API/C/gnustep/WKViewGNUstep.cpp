#include "config.h"
#include "WKViewGNUstep.h"
#include "APIPageConfiguration.h"
#include "WebViewGNUstep.h"
#include "WKAPICast.h"

struct OpaqueWKView {
    RefPtr<WebKit::WebView> view;
};

WKViewGNUstepRef WKViewGNUstepCreate(WKPageConfigurationRef configRef)
{
    auto config = WebKit::toImpl(configRef);
    if (!config)
        return nullptr;

    auto* view = new OpaqueWKView;
    view->view = WebKit::WebView::create(Ref { *config });
    return view;
}

WKPageRef WKViewGNUstepGetPage(WKViewGNUstepRef view)
{
    if (!view || !view->view)
        return nullptr;
    return WebKit::toAPI(view->view->page());
}

void WKViewGNUstepSetSize(WKViewGNUstepRef view, int width, int height)
{
    if (view && view->view)
        view->view->setViewSize({ width, height });
}

int WKViewGNUstepPaint(WKViewGNUstepRef view, unsigned char* buffer, int width, int height, int stride)
{
    if (!view || !view->view)
        return 0;
    return view->view->paintToPixels(buffer, width, height, stride) ? 1 : 0;
}

void WKViewGNUstepDestroy(WKViewGNUstepRef view)
{
    delete view;
}
