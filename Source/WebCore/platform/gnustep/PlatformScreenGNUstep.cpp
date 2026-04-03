#include "config.h"
#include "PlatformScreen.h"
#include "DestinationColorSpace.h"
#include "FloatRect.h"
#include "NotImplemented.h"
#include "Widget.h"

namespace WebCore {

bool screenIsMonochrome(Widget*) { return false; }
bool screenHasInvertedColors() { return false; }
int screenDepth(Widget*) { return 24; }
int screenDepthPerComponent(Widget*) { return 8; }
FloatRect screenRect(Widget*) { return FloatRect(0, 0, 1920, 1080); }
FloatRect screenAvailableRect(Widget*) { return FloatRect(0, 0, 1920, 1080); }
bool screenSupportsExtendedColor(Widget*) { return false; }
DestinationColorSpace screenColorSpace(Widget*) { return DestinationColorSpace::SRGB(); }

} // namespace WebCore
