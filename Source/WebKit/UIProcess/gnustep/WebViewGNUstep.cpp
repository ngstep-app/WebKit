#include "config.h"
#include "WebViewGNUstep.h"

#include "APIPageConfiguration.h"
#include "DrawingAreaProxyCoordinatedGraphics.h"
#include "WebProcessPool.h"
#include "DrawingAreaProxyCoordinatedGraphics.h"
#include "BackingStore.h"
#include <WebCore/Region.h>
#include <skia/core/SkCanvas.h>
#include <skia/core/SkSurface.h>
#include <WebCore/ResourceRequest.h>

namespace WebKit {

Ref<WebView> WebView::create(Ref<API::PageConfiguration>&& configuration)
{
    return adoptRef(*new WebView(std::move(configuration)));
}

WebView::WebView(Ref<API::PageConfiguration>&& configuration)
    : m_pageClient(makeUniqueWithoutRefCountedCheck<PageClientImpl>(*this))
{
    WebProcessPool& processPool = configuration->processPool();
    m_page = processPool.createWebPage(*m_pageClient, std::move(configuration));
    m_page->initializeWebPage(m_page->configuration().openedSite(), m_page->configuration().initialSandboxFlags(), m_page->configuration().initialReferrerPolicy());
    m_page->setIntrinsicDeviceScaleFactor(1.0);
}

WebView::~WebView()
{
    if (m_page)
        m_page->close();
}

void WebView::setViewNeedsDisplay(const WebCore::Region&)
{
    m_needsDisplay = true;
}

void WebView::loadURL(const String& url)
{
    if (m_page)
        m_page->loadRequest(WebCore::ResourceRequest(URL(url)));
}

bool WebView::paintToPixels(uint8_t* buffer, int width, int height, int stride)
{
    if (!m_page || !m_page->drawingArea())
        return false;

    auto* drawingArea = static_cast<DrawingAreaProxyCoordinatedGraphics*>(m_page->drawingArea());

    // Create SkSurface wrapping the output buffer
    SkImageInfo info = SkImageInfo::Make(width, height, kRGBA_8888_SkColorType, kPremul_SkAlphaType);
    auto surface = SkSurfaces::WrapPixels(info, buffer, stride);
    if (!surface)
        return false;

    SkCanvas* canvas = surface->getCanvas();
    canvas->clear(SK_ColorWHITE);

    WebCore::Region unpaintedRegion;
    drawingArea->paint(canvas, WebCore::IntRect(0, 0, width, height), unpaintedRegion);

    return true;
}

} // namespace WebKit
