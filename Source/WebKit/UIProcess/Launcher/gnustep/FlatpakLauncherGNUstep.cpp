#include "config.h"
#include "FlatpakLauncher.h"

namespace WebKit {

GRefPtr<GSubprocess> flatpakSpawn(GSubprocessLauncher*, const ProcessLaunchOptions&, Vector<char*>&, int, GError**)
{
    return nullptr;
}

} // namespace WebKit
