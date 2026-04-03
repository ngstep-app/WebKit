#include "config.h"
#include "InjectedBundle.h"
#include "Module.h"

namespace WebKit {

bool InjectedBundle::initialize(const WebProcessCreationParameters&, RefPtr<API::Object>&&)
{
    return false;
}

void InjectedBundle::setBundleParameters(std::span<const uint8_t>) { }
void InjectedBundle::setBundleParameter(const String&, std::span<const uint8_t>) { }

} // namespace WebKit
