#include "config.h"
#include "MIMETypeRegistry.h"
#include "NotImplemented.h"

namespace WebCore {

String MIMETypeRegistry::mimeTypeForExtension(StringView extension)
{
    static const struct { const char* ext; const char* mime; } map[] = {
        {"html", "text/html"}, {"htm", "text/html"}, {"css", "text/css"},
        {"js", "application/javascript"}, {"json", "application/json"},
        {"png", "image/png"}, {"jpg", "image/jpeg"}, {"jpeg", "image/jpeg"},
        {"gif", "image/gif"}, {"svg", "image/svg+xml"}, {"webp", "image/webp"},
        {"ico", "image/x-icon"}, {"pdf", "application/pdf"},
        {"xml", "application/xml"}, {"txt", "text/plain"},
        {"woff", "font/woff"}, {"woff2", "font/woff2"}, {"ttf", "font/ttf"},
        {"mp3", "audio/mpeg"}, {"mp4", "video/mp4"}, {"webm", "video/webm"},
        {"ogg", "audio/ogg"}, {"wav", "audio/wav"},
    };
    for (auto& entry : map) {
        if (extension == StringView::fromLatin1(entry.ext))
            return String::fromLatin1(entry.mime);
    }
    return "application/octet-stream"_s;
}

Vector<String> MIMETypeRegistry::extensionsForMIMEType(const String&)
{
    notImplemented();
    return { };
}

String MIMETypeRegistry::preferredExtensionForMIMEType(const String&)
{
    notImplemented();
    return { };
}

bool MIMETypeRegistry::isApplicationPluginMIMEType(const String&)
{
    return false;
}

} // namespace WebCore
