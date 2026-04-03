// GNUstep port - WebPageProxy platform stubs
#include "config.h"
#include "WebPageProxy.h"
#include <WebCore/SearchPopupMenu.h>
#include <WebCore/UserAgent.h>

namespace WebKit {

String WebPageProxy::standardUserAgent(const String& applicationNameForUserAgent)
{
    return WebCore::standardUserAgent(applicationNameForUserAgent);
}

void WebPageProxy::saveRecentSearches(IPC::Connection&, const String&, const Vector<WebCore::RecentSearch>&) { }

void WebPageProxy::loadRecentSearches(IPC::Connection&, const String&, CompletionHandler<void(Vector<WebCore::RecentSearch>&&)>&& completionHandler)
{
    completionHandler({ });
}

void WebPageProxy::didUpdateEditorState(const EditorState&, const EditorState&) { }

uint64_t WebPageProxy::viewWidget() { return 0; }

String WebPageProxy::userAgentForURL(const URL&)
{
    return WebCore::standardUserAgent(emptyString());
}

} // namespace WebKit
