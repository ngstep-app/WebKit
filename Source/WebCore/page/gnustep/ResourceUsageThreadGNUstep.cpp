#include "config.h"
#include "ResourceUsageThread.h"
#include "NotImplemented.h"

#if ENABLE(RESOURCE_USAGE)
namespace WebCore {

void ResourceUsageThread::platformSaveStateBeforeStarting() { }
void ResourceUsageThread::platformCollectCPUData(JSC::VM*, ResourceUsageData&) { notImplemented(); }
void ResourceUsageThread::platformCollectMemoryData(JSC::VM*, ResourceUsageData&) { notImplemented(); }

} // namespace WebCore
#endif
