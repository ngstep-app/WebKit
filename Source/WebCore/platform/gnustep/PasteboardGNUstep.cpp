#include "config.h"
#include <wtf/Forward.h>
#include "Pasteboard.h"
#include "NotImplemented.h"

namespace WebCore {

Pasteboard::Pasteboard(std::unique_ptr<PasteboardContext>&& context)
    : m_context(std::move(context))
{
}

std::unique_ptr<Pasteboard> Pasteboard::createForCopyAndPaste(std::unique_ptr<PasteboardContext>&& context)
{
    return std::unique_ptr<Pasteboard>(new Pasteboard(std::move(context)));
}

std::unique_ptr<Pasteboard> Pasteboard::createForDragAndDrop(std::unique_ptr<PasteboardContext>&& context)
{
    return std::unique_ptr<Pasteboard>(new Pasteboard(std::move(context)));
}

std::unique_ptr<Pasteboard> Pasteboard::create(const DragData&)
{
    return std::unique_ptr<Pasteboard>(new Pasteboard(nullptr));
}

void Pasteboard::writeString(const String&, const String&) { notImplemented(); }
void Pasteboard::writePlainText(const String&, SmartReplaceOption) { notImplemented(); }
void Pasteboard::writeMarkup(const String&) { notImplemented(); }
void Pasteboard::writeTrustworthyWebURLsPboardType(const PasteboardURL&) { notImplemented(); }
void Pasteboard::write(const PasteboardURL&) { notImplemented(); }
void Pasteboard::write(const PasteboardImage&) { notImplemented(); }
void Pasteboard::write(const PasteboardBuffer&) { notImplemented(); }
void Pasteboard::write(const PasteboardWebContent&) { notImplemented(); }
void Pasteboard::write(const Color&) { notImplemented(); }
void Pasteboard::writeCustomData(const Vector<PasteboardCustomData>&) { notImplemented(); }
void Pasteboard::clear() { }
void Pasteboard::clear(const String&) { }
bool Pasteboard::canSmartReplace() { return false; }
bool Pasteboard::hasData() { return false; }
String Pasteboard::readOrigin() { return { }; }
String Pasteboard::readString(const String&) { return { }; }
String Pasteboard::readStringInCustomData(const String&) { return { }; }
Pasteboard::FileContentState Pasteboard::fileContentState() { return FileContentState::NoFileOrImageData; }
void Pasteboard::read(PasteboardPlainText&, PlainTextURLReadingPolicy, std::optional<size_t>) { notImplemented(); }
void Pasteboard::read(PasteboardWebContentReader&, WebContentReadingPolicy, std::optional<size_t>) { notImplemented(); }
void Pasteboard::read(PasteboardFileReader&, std::optional<size_t>) { notImplemented(); }
Vector<String> Pasteboard::typesSafeForBindings(const String&) { return { }; }
Vector<String> Pasteboard::typesForLegacyUnsafeBindings() { return { }; }
void Pasteboard::setDragImage(DragImage, const IntPoint&) { notImplemented(); }

} // namespace WebCore
