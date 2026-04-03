#include "config.h"
#include "DrawingAreaCoordinatedGraphics.h"
#include "WebPage.h"
#include "WebPageCreationParameters.h"
#include "LayerTreeHost.h"

namespace WebKit {

DrawingAreaCoordinatedGraphics::DrawingAreaCoordinatedGraphics(WebPage& webPage, const WebPageCreationParameters& parameters)
    : DrawingArea(parameters.drawingAreaIdentifier, webPage)
    , m_displayTimer(RunLoop::mainSingleton(), "DrawingAreaCoordinatedGraphics::DisplayTimer"_s, this, &DrawingAreaCoordinatedGraphics::displayTimerFired)
    , m_exitCompositingTimer(RunLoop::mainSingleton(), "DrawingAreaCoordinatedGraphics::ExitCompositingTimer"_s, this, &DrawingAreaCoordinatedGraphics::exitAcceleratedCompositingMode)
{
}

#if PLATFORM(COCOA) || PLATFORM(GTK) || PLATFORM(WPE) || PLATFORM(GNUSTEP)
void DrawingAreaCoordinatedGraphics::dispatchAfterEnsuringDrawing(IPC::AsyncReplyID)
{
}

void DrawingAreaCoordinatedGraphics::dispatchPendingCallbacksAfterEnsuringDrawing()
{
}
#endif

} // namespace WebKit
