#include "config.h"
#include "PlatformKeyboardEvent.h"
#include "NotImplemented.h"

namespace WebCore {

void PlatformKeyboardEvent::disambiguateKeyDownEvent(PlatformEventType, bool)
{
    notImplemented();
}

OptionSet<PlatformEvent::Modifier> PlatformKeyboardEvent::currentStateOfModifierKeys()
{
    return { };
}

} // namespace WebCore
