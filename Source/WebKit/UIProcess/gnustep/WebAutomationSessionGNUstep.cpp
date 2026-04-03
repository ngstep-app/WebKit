// GNUstep port - WebAutomationSession platform stubs
#include "config.h"
#include "WebAutomationSession.h"
#include "SimulatedInputDispatcher.h"

namespace WebKit {

OptionSet<WebEventModifier> WebAutomationSession::platformWebModifiersFromRaw(WebPageProxy&, unsigned)
{
    return { };
}

void WebAutomationSession::platformSimulateKeyboardInteraction(WebPageProxy&, KeyboardInteraction, Variant<VirtualKey, CharKey>&&)
{
}

void WebAutomationSession::platformSimulateKeySequence(WebPageProxy&, const String&)
{
}

} // namespace WebKit
