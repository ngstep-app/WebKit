#pragma once

#include "DefaultUndoController.h"
#include "APINavigation.h"
#include "PageClient.h"
#include "WebFullScreenManagerProxy.h"
#include "WebPageProxy.h"
#include <WebCore/IntSize.h>

namespace WebKit {

class DrawingAreaProxy;
class WebView;

class PageClientImpl final : public PageClient
#if ENABLE(FULLSCREEN_API)
    , public WebFullScreenManagerProxyClient
#endif
{
    WTF_MAKE_TZONE_ALLOCATED(PageClientImpl);
public:
    PageClientImpl(WebView&);

private:
    Ref<DrawingAreaProxy> createDrawingAreaProxy(WebProcessProxy&) override;
    void setViewNeedsDisplay(const WebCore::Region&) override;
    void requestScroll(const WebCore::FloatPoint&, const WebCore::IntPoint&, WebCore::ScrollIsAnimated, WebCore::InterruptScrollAnimation) override;
    WebCore::FloatPoint viewScrollPosition() override;
    WebCore::IntSize viewSize() override;
    bool isViewWindowActive() override;
    bool isViewFocused() override;
    bool isActiveViewVisible() override;
    bool isViewInWindow() override;
    void processDidExit() override;
    void didRelaunchProcess() override;
    void pageClosed() override;
    void preferencesDidChange() override;
    void toolTipChanged(const String&, const String&) override;
    void setCursor(const WebCore::Cursor&) override;
    void setCursorHiddenUntilMouseMoves(bool) override;
    void registerEditCommand(Ref<WebEditCommandProxy>&&, UndoOrRedo) override;
    void clearAllEditCommands() override;
    bool canUndoRedo(UndoOrRedo) override;
    void executeUndoRedo(UndoOrRedo) override;
    WebCore::FloatRect convertToDeviceSpace(const WebCore::FloatRect&) override;
    WebCore::FloatRect convertToUserSpace(const WebCore::FloatRect&) override;
    WebCore::IntPoint screenToRootView(const WebCore::IntPoint&) override;
    WebCore::IntPoint rootViewToScreen(const WebCore::IntPoint&) override;
    WebCore::IntRect rootViewToScreen(const WebCore::IntRect&) override;
    WebCore::IntPoint accessibilityScreenToRootView(const WebCore::IntPoint&) override;
    WebCore::IntRect rootViewToAccessibilityScreen(const WebCore::IntRect&) override;
    void doneWithKeyEvent(const NativeWebKeyboardEvent&, bool) override;
    RefPtr<WebPopupMenuProxy> createPopupMenuProxy(WebPageProxy&) override;
#if ENABLE(CONTEXT_MENUS)
    Ref<WebContextMenuProxy> createContextMenuProxy(WebPageProxy&, FrameInfoData&&, ContextMenuContextData&&, const UserData&) override;
#endif
    RefPtr<WebColorPicker> createColorPicker(WebPageProxy&, const WebCore::Color&, const WebCore::IntRect&, ColorControlSupportsAlpha, Vector<WebCore::Color>&&, std::optional<WebCore::FrameIdentifier>) override { return nullptr; }
    RefPtr<WebDataListSuggestionsDropdown> createDataListSuggestionsDropdown(WebPageProxy&) override { return nullptr; }
    RefPtr<WebDateTimePicker> createDateTimePicker(WebPageProxy&) override { return nullptr; }
    void enterAcceleratedCompositingMode(const LayerTreeContext&) override;
    void exitAcceleratedCompositingMode() override;
    void updateAcceleratedCompositingMode(const LayerTreeContext&) override;
    bool handleRunOpenPanel(const WebPageProxy&, const WebFrameProxy&, const FrameInfoData&, API::OpenPanelParameters&, WebOpenPanelResultListenerProxy&) override { return false; }
    void didChangeContentSize(const WebCore::IntSize&) override;
    void didCommitLoadForMainFrame(const String&, bool) override;
    void didFirstVisuallyNonEmptyLayoutForMainFrame() override;
    void didFinishNavigation(API::Navigation*) override;
    void didFailNavigation(API::Navigation*) override { }
    void didSameDocumentNavigationForMainFrame(SameDocumentNavigationType) override;
#if ENABLE(FULLSCREEN_API)
    WebFullScreenManagerProxyClient& fullScreenManagerProxyClient() final;
    void setFullScreenClientForTesting(std::unique_ptr<WebFullScreenManagerProxyClient>&&) final { }
    void closeFullScreenManager() override { }
    bool isFullScreen() override { return false; }
    void enterFullScreen(WebCore::FloatSize, CompletionHandler<void(bool)>&& cb) override { cb(false); }
    void exitFullScreen(CompletionHandler<void()>&& cb) override { cb(); }
    void beganEnterFullScreen(const WebCore::IntRect&, const WebCore::IntRect&, CompletionHandler<void(bool)>&& cb) override { cb(false); }
    void beganExitFullScreen(const WebCore::IntRect&, const WebCore::IntRect&, CompletionHandler<void()>&& cb) override { cb(); }
#endif
    void didFinishLoadingDataForCustomContentProvider(const String&, std::span<const uint8_t>) override { }
    void navigationGestureDidBegin() override { }
    void navigationGestureWillEnd(bool, WebBackForwardListItem&) override { }
    void navigationGestureDidEnd(bool, WebBackForwardListItem&) override { }
    void navigationGestureDidEnd() override { }
    void willRecordNavigationSnapshot(WebBackForwardListItem&) override { }
    void didRemoveNavigationGestureSnapshot() override { }
    void wheelEventWasNotHandledByWebCore(const NativeWebWheelEvent&) override { }
    void didChangeBackgroundColor() override { }
    void isPlayingAudioWillChange() override { }
    void isPlayingAudioDidChange() override { }
    void refView() override { }
    void derefView() override { }
    void didRestoreScrollPosition() override { }
    WebCore::UserInterfaceLayoutDirection userInterfaceLayoutDirection() override { return WebCore::UserInterfaceLayoutDirection::LTR; }
    void requestDOMPasteAccess(WebCore::DOMPasteAccessCategory, WebCore::DOMPasteRequiresInteraction, const WebCore::IntRect&, const String&, CompletionHandler<void(WebCore::DOMPasteAccessResponse)>&&) final;

    DefaultUndoController m_undoController;
    WebView& m_view;
};

} // namespace WebKit
