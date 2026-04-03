#include "config.h"
#include "WebAutomationSession.h"
#include "WebPageProxy.h"

namespace WebKit {

void WebAutomationSession::platformSimulateMouseInteraction(WebPageProxy&, Inspector::Protocol::Automation::MouseInteraction, Inspector::Protocol::Automation::MouseButton, const WebCore::IntPoint&, OptionSet<WebEventModifier>, const String&)
{
}

} // namespace WebKit
