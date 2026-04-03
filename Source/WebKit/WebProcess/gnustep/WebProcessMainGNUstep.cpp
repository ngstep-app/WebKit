#include "config.h"
#include "WebProcessMain.h"
#include "AuxiliaryProcessMain.h"
#include "WebProcess.h"

#if USE(GCRYPT)
#include <pal/crypto/gcrypt/Initialization.h>
#endif

namespace WebKit {

class WebProcessMainGNUstep final : public AuxiliaryProcessMainBase<WebProcess> {
public:
    bool platformInitialize() override
    {
#if USE(GCRYPT)
        PAL::GCrypt::initialize();
#endif
        return true;
    }
};

int WebProcessMain(int argc, char** argv)
{
    return AuxiliaryProcessMain<WebProcessMainGNUstep>(argc, argv);
}

} // namespace WebKit
