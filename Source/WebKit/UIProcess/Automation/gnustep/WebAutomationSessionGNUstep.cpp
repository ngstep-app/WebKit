#include "config.h"
#include "WebAutomationSession.h"
#include "WebPageProxy.h"

namespace WebKit {

void WebAutomationSession::platformSimulateMouseInteraction(WebPageProxy&, Inspector::Protocol::Automation::MouseInteraction, Inspector::Protocol::Automation::MouseButton, const WebCore::IntPoint&, OptionSet<WebEventModifier>, const String&) { }

void WebAutomationSession::platformSimulateKeyboardInteraction(WebPageProxy&, Inspector::Protocol::Automation::KeyboardInteractionType, mpark::variant<Inspector::Protocol::Automation::VirtualKey, char32_t>&&) { }

void WebAutomationSession::platformSimulateKeySequence(WebPageProxy&, const String&) { }

OptionSet<WebEventModifier> WebAutomationSession::platformWebModifiersFromRaw(WebPageProxy&, unsigned) { return { }; }

} // namespace WebKit
