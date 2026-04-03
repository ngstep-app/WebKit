#include "config.h"
#include "UserAgent.h"

namespace WebCore {

String standardUserAgent(const String&, const String&)
{
    return "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/605.1.15 (KHTML, like Gecko) MiniBrowser/1.0"_s;
}

} // namespace WebCore
