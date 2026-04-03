#include "config.h"
#include "SleepDisabler.h"

namespace PAL {

std::unique_ptr<SleepDisabler> SleepDisabler::create(const String&, SleepDisabler::Type)
{
    return nullptr;
}

} // namespace PAL
