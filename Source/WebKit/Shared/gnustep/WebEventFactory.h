// GNUstep port
#pragma once

namespace WebCore {
class PlatformMouseEvent;
}

namespace WebKit {

class WebEventFactory {
public:
    static bool shouldBeHandledAsContextClick(const WebCore::PlatformMouseEvent&);
};

} // namespace WebKit
