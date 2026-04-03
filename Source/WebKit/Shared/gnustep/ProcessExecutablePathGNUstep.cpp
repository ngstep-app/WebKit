#include "config.h"
#include "ProcessExecutablePath.h"
#include <wtf/FileSystem.h>

namespace WebKit {

String executablePathOfWebProcess() { return "/usr/libexec/WebKitWebProcess"_s; }
String executablePathOfNetworkProcess() { return "/usr/libexec/WebKitNetworkProcess"_s; }

} // namespace WebKit
