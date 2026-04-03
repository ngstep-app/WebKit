#include "config.h"
#include <wtf/Language.h>

#import <Foundation/Foundation.h>

namespace WTF {

Vector<String> platformUserPreferredLanguages(ShouldMinimizeLanguages)
{
    @autoreleasepool {
        Vector<String> languages;
        NSArray *preferredLanguages = [NSLocale preferredLanguages];
        for (NSString *lang in preferredLanguages)
            languages.append(String::fromUTF8([lang UTF8String]));
        if (languages.isEmpty())
            languages.append("en-US"_s);
        return languages;
    }
}

} // namespace WTF
