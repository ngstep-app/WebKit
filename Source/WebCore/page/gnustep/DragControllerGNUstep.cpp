#include "config.h"
#include "DragController.h"
#include "DragData.h"
#include "NotImplemented.h"

namespace WebCore {

const int DragController::DragIconRightInset = 7;
const int DragController::DragIconBottomInset = 3;
const float DragController::DragImageAlpha = 0.75f;
const int DragController::MaxOriginalImageArea = 1500 * 1500;

static const IntSize s_maxDragImageSize(400, 400);

bool DragController::isCopyKeyDown(const DragData&) { return false; }
std::optional<DragOperation> DragController::dragOperation(const DragData&) { return std::nullopt; }
void DragController::cleanupAfterSystemDrag() { }
void DragController::declareAndWriteDragImage(DataTransfer&, Element&, const URL&, const String&) { notImplemented(); }
const IntSize& DragController::maxDragImageSize() { return s_maxDragImageSize; }

} // namespace WebCore
