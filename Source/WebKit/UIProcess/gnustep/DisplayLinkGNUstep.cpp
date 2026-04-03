// GNUstep port - DisplayLink platform stubs
#include "config.h"
#include "DisplayLink.h"

namespace WebKit {

void DisplayLink::platformInitialize() { }
void DisplayLink::platformFinalize() { }
bool DisplayLink::platformIsRunning() const { return false; }
void DisplayLink::platformStart() { }
void DisplayLink::platformStop() { }

} // namespace WebKit
