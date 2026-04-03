#include "config.h"
#include "PageClientImplGNUstep.h"

#include "DrawingAreaProxyCoordinatedGraphics.h"
#include "WebPageProxy.h"
#include "WebViewGNUstep.h"
#include <WebCore/DOMPasteAccess.h>
#include "APINavigation.h"
#include <WebCore/NotImplemented.h>
#include <wtf/TZoneMallocInlines.h>

namespace WebKit {
using namespace WebCore;

WTF_MAKE_TZONE_ALLOCATED_IMPL(PageClientImpl);

PageClientImpl::PageClientImpl(WebView& view)
    : m_view(view)
{
}

Ref<DrawingAreaProxy> PageClientImpl::createDrawingAreaProxy(WebProcessProxy& process)
{
    return DrawingAreaProxyCoordinatedGraphics::create(*m_view.page(), process);
}

void PageClientImpl::setViewNeedsDisplay(const Region& region)
{
    m_view.setViewNeedsDisplay(region);
}

void PageClientImpl::requestScroll(const FloatPoint&, const IntPoint&, ScrollIsAnimated, InterruptScrollAnimation) { }
FloatPoint PageClientImpl::viewScrollPosition() { return { }; }
IntSize PageClientImpl::viewSize() { return m_view.viewSize(); }
bool PageClientImpl::isViewWindowActive() { return m_view.isWindowActive(); }
bool PageClientImpl::isViewFocused() { return m_view.isFocused(); }
bool PageClientImpl::isActiveViewVisible() { return m_view.isVisible(); }
bool PageClientImpl::isViewInWindow() { return m_view.isInWindow(); }
void PageClientImpl::processDidExit() { notImplemented(); }
void PageClientImpl::didRelaunchProcess() { notImplemented(); }
void PageClientImpl::pageClosed() { }
void PageClientImpl::preferencesDidChange() { }
void PageClientImpl::toolTipChanged(const String&, const String&) { }
void PageClientImpl::setCursor(const Cursor&) { notImplemented(); }
void PageClientImpl::setCursorHiddenUntilMouseMoves(bool) { }

void PageClientImpl::registerEditCommand(Ref<WebEditCommandProxy>&& cmd, UndoOrRedo op)
{
    m_undoController.registerEditCommand(std::move(cmd), op);
}

void PageClientImpl::clearAllEditCommands() { m_undoController.clearAllEditCommands(); }
bool PageClientImpl::canUndoRedo(UndoOrRedo op) { return m_undoController.canUndoRedo(op); }
void PageClientImpl::executeUndoRedo(UndoOrRedo op) { m_undoController.executeUndoRedo(op); }

FloatRect PageClientImpl::convertToDeviceSpace(const FloatRect& r) { return r; }
FloatRect PageClientImpl::convertToUserSpace(const FloatRect& r) { return r; }
IntPoint PageClientImpl::screenToRootView(const IntPoint& p) { return p; }
IntPoint PageClientImpl::rootViewToScreen(const IntPoint& p) { return p; }
IntRect PageClientImpl::rootViewToScreen(const IntRect& r) { return r; }
IntPoint PageClientImpl::accessibilityScreenToRootView(const IntPoint& p) { return p; }
IntRect PageClientImpl::rootViewToAccessibilityScreen(const IntRect& r) { return r; }
void PageClientImpl::doneWithKeyEvent(const NativeWebKeyboardEvent&, bool) { }

RefPtr<WebPopupMenuProxy> PageClientImpl::createPopupMenuProxy(WebPageProxy&)
{
    return nullptr;
}

#if ENABLE(CONTEXT_MENUS)
Ref<WebContextMenuProxy> PageClientImpl::createContextMenuProxy(WebPageProxy&, FrameInfoData&&, ContextMenuContextData&&, const UserData&)
{
    RELEASE_ASSERT_NOT_REACHED();
}
#endif

void PageClientImpl::enterAcceleratedCompositingMode(const LayerTreeContext&) { }
void PageClientImpl::exitAcceleratedCompositingMode() { }
void PageClientImpl::updateAcceleratedCompositingMode(const LayerTreeContext&) { }
void PageClientImpl::didChangeContentSize(const IntSize&) { }
void PageClientImpl::didCommitLoadForMainFrame(const String&, bool) { }
void PageClientImpl::didFirstVisuallyNonEmptyLayoutForMainFrame() { }
void PageClientImpl::didFinishNavigation(API::Navigation*) { }
void PageClientImpl::didSameDocumentNavigationForMainFrame(SameDocumentNavigationType) { }

#if ENABLE(FULLSCREEN_API)
WebFullScreenManagerProxyClient& PageClientImpl::fullScreenManagerProxyClient()
{
    return *this;
}
#endif

void PageClientImpl::requestDOMPasteAccess(DOMPasteAccessCategory, DOMPasteRequiresInteraction, const IntRect&, const String&, CompletionHandler<void(DOMPasteAccessResponse)>&& cb)
{
    cb(DOMPasteAccessResponse::DeniedForGesture);
}

} // namespace WebKit
