#include "config.h"

#if PLATFORM(GTK) || PLATFORM(WPE) || PLATFORM(GNUSTEP)

#include "Editor.h"
#include "DocumentFragment.h"
#include "NotImplemented.h"
#include "Pasteboard.h"

namespace WebCore {

void Editor::pasteWithPasteboard(Pasteboard*, OptionSet<PasteOption>)
{
    notImplemented();
}

void Editor::writeSelectionToPasteboard(Pasteboard&)
{
    notImplemented();
}

void Editor::writeImageToPasteboard(Pasteboard&, Element&, const URL&, const String&)
{
    notImplemented();
}

RefPtr<DocumentFragment> Editor::webContentFromPasteboard(Pasteboard&, const SimpleRange&, bool, bool&)
{
    notImplemented();
    return nullptr;
}

void Editor::platformCopyFont()
{
}

void Editor::platformPasteFont()
{
}

} // namespace WebCore

#endif
