#include "config.h"
#include "DragData.h"
#include "NotImplemented.h"

namespace WebCore {

bool DragData::canSmartReplace() const { return false; }
bool DragData::containsColor() const { return false; }
bool DragData::containsFiles() const { return false; }
bool DragData::containsPlainText() const { return false; }
bool DragData::containsURL(FilenameConversionPolicy) const { return false; }
bool DragData::containsCompatibleContent(DraggingPurpose) const { return false; }
bool DragData::shouldMatchStyleOnDrop() const { return false; }
unsigned DragData::numberOfFiles() const { return 0; }
Vector<String> DragData::asFilenames() const { return { }; }
String DragData::asPlainText() const { return { }; }
Color DragData::asColor() const { return Color::transparentBlack; }
String DragData::asURL(FilenameConversionPolicy, String*) const { return { }; }

} // namespace WebCore
