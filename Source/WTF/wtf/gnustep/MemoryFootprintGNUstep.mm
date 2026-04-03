#include "config.h"
#include <wtf/MemoryFootprint.h>

#include <sys/resource.h>

namespace WTF {

size_t memoryFootprint()
{
    struct rusage usage;
    if (getrusage(RUSAGE_SELF, &usage) == 0)
        return usage.ru_maxrss * 1024;
    return 0;
}

} // namespace WTF
