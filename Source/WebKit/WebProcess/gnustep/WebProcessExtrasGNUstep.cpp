// GNUstep port - WebProcess platform stubs
#include "config.h"
#include "WebProcess.h"
#include "WebProcessCreationParameters.h"

namespace WebKit {

void WebProcess::platformInitializeProcess(const AuxiliaryProcessInitializationParameters&) { }
void WebProcess::platformInitializeWebProcess(WebProcessCreationParameters&) { }
void WebProcess::platformSetCacheModel(CacheModel) { }
void WebProcess::platformTerminate() { }
void WebProcess::platformSetWebsiteDataStoreParameters(WebProcessDataStoreParameters&&) { }
void WebProcess::grantAccessToAssetServices(Vector<SandboxExtensionHandle>&&) { }
void WebProcess::revokeAccessToAssetServices() { }
void WebProcess::switchFromStaticFontRegistryToUserFontRegistry(Vector<SandboxExtensionHandle>&&) { }

} // namespace WebKit
