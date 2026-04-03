#include "config.h"
#include "WebPage.h"
#include "EditorState.h"

namespace WebKit {

void WebPage::getPlatformEditorState(WebCore::LocalFrame&, EditorState&) const { }
bool WebPage::platformCanHandleRequest(const WebCore::ResourceRequest&) { return true; }

} // namespace WebKit
