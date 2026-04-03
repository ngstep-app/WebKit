list(APPEND WebCore_UNIFIED_SOURCE_LIST_FILES
    "SourcesGNUstep.txt"
)

include(platform/Adwaita.cmake)
include(platform/GCrypt.cmake)
include(platform/GStreamer.cmake)
include(platform/ImageDecoders.cmake)
include(platform/Curl.cmake)
# Note: Using GCrypt for crypto (via GCrypt.cmake include above)
include(platform/TextureMapper.cmake)

if (USE_SKIA)
    include(platform/Skia.cmake)
endif ()

list(APPEND WebCore_PRIVATE_INCLUDE_DIRECTORIES
    "${WEBCORE_DIR}/crypto/openssl"
    "${WEBCORE_DIR}/platform/generic"
    "${WEBCORE_DIR}/platform/network/glib"
    "${WEBCORE_DIR}/platform/glib"
    "${WEBCORE_DIR}/platform/gnustep"
    "${WEBCORE_DIR}/platform/graphics/egl"
    "${WEBCORE_DIR}/platform/graphics/epoxy"
    "${WEBCORE_DIR}/platform/graphics/gbm"
    "${WEBCORE_DIR}/platform/graphics/glib"
    "${WEBCORE_DIR}/platform/graphics/gstreamer"
    "${WEBCORE_DIR}/platform/graphics/opengl"
    "${WEBCORE_DIR}/platform/graphics/opentype"
    "${WEBCORE_DIR}/platform/graphics/x11"
    "${WEBCORE_DIR}/platform/mediacapabilities"
    "${WEBCORE_DIR}/platform/mediastream/gstreamer"
    "${WEBCORE_DIR}/platform/mock/mediasource"
    "${WEBCORE_DIR}/platform/network/curl"
    "${WEBCORE_DIR}/platform/video-codecs"
    "${WEBCORE_DIR}/platform/text"
    "${WEBCORE_DIR}/page/scrolling"
    "${WEBCORE_DIR}/page/scrolling/coordinated"
    "${WEBCORE_DIR}/rendering/gnustep"
    ${GNUSTEP_INCLUDE_DIRS}
)

list(APPEND WebCore_SOURCES
    accessibility/gnustep/AXObjectCacheGNUstep.cpp
    accessibility/gnustep/AccessibilityObjectGNUstep.cpp


    page/gnustep/DragControllerGNUstep.cpp
    page/gnustep/EventHandlerGNUstep.cpp
    page/gnustep/ResourceUsageOverlayGNUstep.cpp

    platform/Cursor.cpp
    platform/LocalizedStrings.cpp
    platform/StaticPasteboard.cpp

    platform/audio/PlatformMediaSessionManager.cpp

    platform/generic/KeyedDecoderGeneric.cpp
    platform/generic/KeyedEncoderGeneric.cpp

    platform/glib/ApplicationGLib.cpp
    platform/glib/FileMonitorGLib.cpp
    platform/glib/LowPowerModeNotifierGLib.cpp
    platform/glib/RunLoopObserverGLib.cpp
    platform/glib/SharedBufferGlib.cpp
    platform/glib/SystemSettings.cpp
    platform/glib/UserAgentQuirks.cpp



    platform/graphics/glib/IconGLib.cpp

    platform/graphics/gnustep/SystemFontDatabaseGNUstep.cpp


    platform/gnustep/PlatformScreenGNUstep.cpp

    platform/gnustep/CursorGNUstep.mm
    platform/gnustep/DragDataGNUstep.cpp
    platform/gnustep/KeyEventGNUstep.mm
    platform/gnustep/LocalizedStringsGNUstep.mm
    platform/gnustep/MIMETypeRegistryGNUstep.mm
    platform/network/gnustep/NetworkStorageSessionGNUstep.cpp
    platform/gnustep/UserAgentGNUstep.cpp
    platform/gnustep/PasteboardGNUstep.cpp
    platform/network/curl/CurlSSLHandleGNUstep.cpp
    platform/gnustep/SharedMemoryGNUstep.cpp
    platform/gnustep/PlatformMouseEventGNUstep.mm
    platform/gnustep/ThemeGNUstep.mm
    platform/gnustep/UserAgentGNUstep.mm
    platform/gnustep/WheelEventGNUstep.mm

    platform/network/gnustep/NetworkStateNotifierGNUstep.cpp
    platform/network/glib/DNSResolveQueueGLib.cpp
    page/gnustep/ResourceUsageThreadGNUstep.cpp
    platform/graphics/gnustep/OpenTypeVerticalDataGNUstep.cpp
    platform/gnustep/SleepDisablerGNUstep.cpp

    platform/text/Hyphenation.cpp
    platform/text/LocaleICU.cpp
    platform/text/enchant/TextCheckerEnchant.cpp

    platform/unix/LoggingUnix.cpp
)

if (USE_SKIA)
    list(APPEND WebCore_SOURCES
    )
    list(APPEND WebCore_PRIVATE_LIBRARIES ${SHARPYUV_LIBS})
else ()
    list(APPEND WebCore_SOURCES
        platform/gnustep/DragImageGNUstep.cpp
    )
endif ()

list(APPEND WebCore_PRIVATE_LIBRARIES
    ${GNUSTEP_LIBRARIES}
)

list(APPEND WebCore_SYSTEM_INCLUDE_DIRECTORIES
    ${GNUSTEP_INCLUDE_DIRS}
)

