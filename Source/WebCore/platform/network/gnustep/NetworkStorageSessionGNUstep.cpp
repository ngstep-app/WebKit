#include "config.h"
#include "NetworkStorageSession.h"

namespace WebCore {

bool NetworkStorageSession::startListeningForCookieChangeNotifications(CookieChangeObserver&, const URL&, const URL&, FrameIdentifier, PageIdentifier, ShouldRelaxThirdPartyCookieBlocking, IsKnownCrossSiteTracker)
{
    return false;
}

void NetworkStorageSession::stopListeningForCookieChangeNotifications(CookieChangeObserver&, const HashSet<String>&)
{
}

} // namespace WebCore
