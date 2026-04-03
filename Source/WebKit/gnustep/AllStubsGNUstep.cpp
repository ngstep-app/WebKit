#include "config.h"
#include "DrawingAreaCoordinatedGraphics.h"
#include "BubblewrapLauncher.h"
#include "FlatpakLauncher.h"
#include "XDGDBusProxy.h"
#include "ProcessLauncher.h"
#include <wtf/text/CString.h>

namespace WebKit {

void DrawingAreaCoordinatedGraphics::dispatchAfterEnsuringDrawing(IPC::AsyncReplyID) { }
void DrawingAreaCoordinatedGraphics::dispatchPendingCallbacksAfterEnsuringDrawing() { }

GRefPtr<GSubprocess> bubblewrapSpawn(GSubprocessLauncher*, const ProcessLauncher::LaunchOptions&, XDGDBusProxy&, Vector<char*>&, GError**)
{ return nullptr; }

int argumentsToFileDescriptor(const Vector<CString>&, const char*)
{ return -1; }

GRefPtr<GSubprocess> flatpakSpawn(GSubprocessLauncher*, const ProcessLauncher::LaunchOptions&, Vector<char*>&, int, GError**)
{ return nullptr; }

} // namespace WebKit
