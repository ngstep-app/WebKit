#pragma once

#include "PageClientImplGNUstep.h"
#include "WebPageProxy.h"
#include <WebCore/IntSize.h>
#include <wtf/RefCounted.h>

namespace API {
class PageConfiguration;
}

namespace WebKit {

class WebView : public RefCounted<WebView> {
public:
    static Ref<WebView> create(Ref<API::PageConfiguration>&&);
    ~WebView();

    WebPageProxy* page() const { return m_page.get(); }

    // Called by PageClientImpl
    WebCore::IntSize viewSize() const { return m_viewSize; }
    bool isWindowActive() const { return true; }
    bool isFocused() const { return true; }
    bool isVisible() const { return true; }
    bool isInWindow() const { return true; }
    void setViewNeedsDisplay(const WebCore::Region&);
    void setViewSize(const WebCore::IntSize& size) { m_viewSize = size; }

    void loadURL(const String& url);
    bool paintToPixels(uint8_t* buffer, int width, int height, int stride);

private:
    WebView(Ref<API::PageConfiguration>&&);

    std::unique_ptr<PageClientImpl> m_pageClient;
    RefPtr<WebPageProxy> m_page;
    bool m_needsDisplay { false };
    WebCore::IntSize m_viewSize { 1024, 768 };
};

} // namespace WebKit
