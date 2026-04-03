// GNUstep port - WebProcessPool platform stubs
#include "config.h"
#include "WebProcessPool.h"
#include "NetworkProcessCreationParameters.h"

namespace WebKit {

void WebProcessPool::platformInitialize(NeedsGlobalStaticInitialization) { }
void WebProcessPool::platformInvalidateContext() { }
void WebProcessPool::platformResolvePathsForSandboxExtensions() { }
void WebProcessPool::platformInitializeNetworkProcess(NetworkProcessCreationParameters&) { }
void WebProcessPool::platformInitializeWebProcess(const WebProcessProxy&, WebProcessCreationParameters&) { }

} // namespace WebKit
