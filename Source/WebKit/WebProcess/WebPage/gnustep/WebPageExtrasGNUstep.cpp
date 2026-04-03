// GNUstep port - WebPage platform stubs
#include "config.h"
#include "WebPage.h"

#include <WebCore/UserAgent.h>

namespace WebKit {

void WebPage::platformInitialize(const WebPageCreationParameters&) { }
void WebPage::platformDetach() { }
void WebPage::platformReinitializeAccessibilityToken() { }

String WebPage::platformUserAgent(const URL& url) const
{
    return WebCore::standardUserAgent(emptyString());
}

bool WebPage::hoverSupportedByPrimaryPointingDevice() const { return true; }
bool WebPage::hoverSupportedByAnyAvailablePointingDevice() const { return true; }
std::optional<WebCore::PointerCharacteristics> WebPage::pointerCharacteristicsOfPrimaryPointingDevice() const { return std::nullopt; }
OptionSet<WebCore::PointerCharacteristics> WebPage::pointerCharacteristicsOfAllAvailablePointingDevices() const { return { }; }

} // namespace WebKit
