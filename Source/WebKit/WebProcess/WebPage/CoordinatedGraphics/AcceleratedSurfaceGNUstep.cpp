#include "config.h"
#include "AcceleratedSurface.h"
#include "WebPage.h"

namespace WebKit {

AcceleratedSurface::~AcceleratedSurface() = default;
void AcceleratedSurface::backgroundColorDidChange() { }
void AcceleratedSurface::clear(const OptionSet<WebCore::CompositionReason>&) { }
void AcceleratedSurface::didCreateCompositingRunLoop(RunLoop&) { }
void AcceleratedSurface::didRenderFrame() { }
void AcceleratedSurface::sendFrame() { }
void AcceleratedSurface::visibilityDidChange(bool) { }
void AcceleratedSurface::willDestroyCompositingRunLoop() { }
void AcceleratedSurface::willDestroyGLContext() { }
void AcceleratedSurface::willRenderFrame(const WebCore::IntSize&) { }
uint64_t AcceleratedSurface::window() { return 0; }

Ref<AcceleratedSurface> AcceleratedSurface::create(WebPage& page, Function<void()>&& cb, RenderingPurpose)
{
    RELEASE_ASSERT_NOT_REACHED();
}

} // namespace WebKit
