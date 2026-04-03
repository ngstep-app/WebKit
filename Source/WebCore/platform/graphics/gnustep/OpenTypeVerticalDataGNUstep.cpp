#include "config.h"
#include "OpenTypeVerticalData.h"
#include "NotImplemented.h"

namespace WebCore {

RefPtr<OpenTypeVerticalData> OpenTypeVerticalData::create(const FontPlatformData&)
{
    return nullptr;
}

void OpenTypeVerticalData::substituteWithVerticalGlyphs(const Font*, GlyphPage*) const
{
    notImplemented();
}

float OpenTypeVerticalData::advanceHeight(const Font*, Glyph) const
{
    return 0;
}

} // namespace WebCore
