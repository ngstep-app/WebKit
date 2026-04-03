
set(WebKit_OUTPUT_NAME WebKit2)
set(WebProcess_OUTPUT_NAME WebKitWebProcess)
set(NetworkProcess_OUTPUT_NAME WebKitNetworkProcess)
set(GPUProcess_OUTPUT_NAME WebKitGPUProcess)

include(Headers.cmake)
include(Platform/Curl.cmake)
include(Platform/Skia.cmake)

list(APPEND WebKit_SOURCES
    NetworkProcess/NetworkDataTaskDataURL.cpp

    NetworkProcess/Classifier/WebResourceLoadStatisticsStore.cpp

    NetworkProcess/cache/NetworkCacheDataGLib.cpp
    NetworkProcess/cache/NetworkCacheIOChannelGLib.cpp

    Platform/IPC/glib/ConnectionGLib.cpp
    Platform/IPC/unix/IPCSemaphoreUnix.cpp

    Platform/classifier/ResourceLoadStatisticsClassifier.cpp

    Platform/gnustep/LoggingGNUstep.mm

    Shared/gnustep/WebEventFactoryGNUstep.mm
    Shared/gnustep/NativeWebKeyboardEventGNUstep.mm
    Shared/gnustep/NativeWebMouseEventGNUstep.mm
    Shared/gnustep/NativeWebWheelEventGNUstep.mm

    UIProcess/API/C/WKViewportAttributes.cpp

    UIProcess/DefaultUndoController.cpp
    UIProcess/LegacySessionStateCodingNone.cpp
    UIProcess/WebGrammarDetail.cpp
    UIProcess/WebViewportAttributes.cpp

    UIProcess/CoordinatedGraphics/DrawingAreaProxyCoordinatedGraphics.cpp


    UIProcess/gnustep/PageClientImplGNUstep.cpp
    UIProcess/gnustep/WebViewGNUstep.cpp
    UIProcess/gnustep/WebContextMenuProxyGNUstep.mm
    UIProcess/gnustep/WebPageProxyGNUstep.mm
    UIProcess/gnustep/WebPopupMenuProxyGNUstep.mm
    UIProcess/gnustep/WebProcessPoolGNUstep.mm
    UIProcess/gnustep/WebsiteDataStoreGNUstep.mm

    WebProcess/InjectedBundle/gnustep/InjectedBundleGNUstep.mm

    WebProcess/Inspector/gnustep/RemoteWebInspectorUIGNUstep.mm
    WebProcess/Inspector/gnustep/WebInspectorUIGNUstep.mm


    # Platform stubs - unix/linux/glib implementations
    Platform/IPC/unix/IPCUtilitiesUnix.cpp

    Platform/unix/LoggingUnix.cpp

    Shared/linux/WebMemorySamplerLinux.cpp
    Shared/unix/AuxiliaryProcessMain.cpp

    UIProcess/Launcher/glib/ProcessLauncherGLib.cpp
    UIProcess/linux/MemoryPressureMonitor.cpp

    UIProcess/skia/BackingStoreSkia.cpp
    WebProcess/WebPage/CoordinatedGraphics/ScrollingCoordinatorCoordinated.cpp
    UIProcess/gnustep/WebAutomationSessionGNUstep.cpp

    UIProcess/WebsiteData/glib/WebsiteDataStoreGLib.cpp
    UIProcess/gnustep/DisplayLinkGNUstep.cpp
    UIProcess/gnustep/WebPageProxyExtrasGNUstep.cpp
    UIProcess/gnustep/WebProcessPoolExtrasGNUstep.cpp
    UIProcess/gnustep/WebProcessProxyExtrasGNUstep.cpp
    WebProcess/WebPage/gnustep/WebPageExtrasGNUstep.cpp
    WebProcess/gnustep/WebProcessExtrasGNUstep.cpp


    WebProcess/WebPage/CoordinatedGraphics/LayerTreeHost.cpp

    WebProcess/MediaCache/WebMediaKeyStorageManager.cpp


    WebProcess/WebPage/gnustep/WebPageGNUstep.mm

    WebProcess/WebPage/CoordinatedGraphics/AcceleratedSurfaceGNUstep.cpp
    WebProcess/WebPage/CoordinatedGraphics/DrawingAreaCoordinatedGraphics.cpp

    WebProcess/WebPage/CoordinatedGraphics/CoordinatedSceneState.cpp
    WebProcess/WebPage/CoordinatedGraphics/FrameRenderer.cpp
    WebProcess/WebPage/CoordinatedGraphics/ThreadedCompositor.cpp
    WebProcess/WebPage/CoordinatedGraphics/ScrollbarsControllerCoordinated.cpp
    Shared/gnustep/ProcessExecutablePathGNUstep.cpp
    UIProcess/Launcher/glib/XDGDBusProxy.cpp
    Platform/glib/ModuleGlib.cpp
    WebProcess/InjectedBundle/gnustep/InjectedBundleGNUstep.cpp
    WebProcess/WebCoreSupport/gnustep/WebEditorClientGNUstep.cpp
    WebProcess/WebPage/gnustep/WebPageGNUstep.cpp
    UIProcess/gnustep/WebPageProxyGNUstep.cpp
    gnustep/AllStubsGNUstep.cpp
    WebProcess/gnustep/WebProcessMainGNUstep.mm
    WebProcess/gnustep/WebProcessGNUstep.mm
)

list(APPEND WebKit_PRIVATE_INCLUDE_DIRECTORIES
    "${WEBKIT_DIR}/Platform/IPC/glib"
    "${WEBKIT_DIR}/WebProcess/WebPage/CoordinatedGraphics"
    "${WEBKIT_DIR}/UIProcess/linux"
    "${WEBKIT_DIR}/Platform/generic"
    "${WEBKIT_DIR}/Platform/classifier"
    "${WEBKIT_DIR}/Shared/glib"
    "${WEBKIT_DIR}/Platform/IPC/unix"
    "${WEBKIT_DIR}/Platform/gnustep"
    "${WEBKIT_DIR}/Shared/gnustep"
    "${WEBKIT_DIR}/UIProcess/gnustep"
    "${WEBKIT_DIR}/UIProcess/CoordinatedGraphics"
    "${WEBKIT_DIR}/WebProcess/gnustep"
    "${WEBKIT_DIR}/UIProcess/glib"
    "${WEBKIT_DIR}/WebProcess/glib"
    "${WEBKIT_DIR}/WebProcess/WebCoreSupport/glib"
    "${WEBKIT_DIR}/UIProcess/Launcher/glib"
    "${WEBKIT_DIR}/Platform/glib"
    "${WEBKIT_DIR}/UIProcess/Automation/gnustep"
    ${GNUSTEP_INCLUDE_DIRS}
    ${GSTREAMER_INCLUDE_DIRS}
    ${GSTREAMER_PBUTILS_INCLUDE_DIRS}
)

list(APPEND WebKit_LIBRARIES
    ${GNUSTEP_LIBRARIES}
    GLib::Gio
    gmodule-2.0
)

list(APPEND WebKit_SYSTEM_INCLUDE_DIRECTORIES
    ${GNUSTEP_INCLUDE_DIRS}
    ${GSTREAMER_INCLUDE_DIRS}
    ${GSTREAMER_PBUTILS_INCLUDE_DIRS}
)

# Override curl cache with GLib cache (USE_GLIB types incompatible with curl cache)
list(REMOVE_ITEM WebKit_SOURCES
    NetworkProcess/cache/NetworkCacheDataCurl.cpp
    NetworkProcess/cache/NetworkCacheIOChannelCurl.cpp
)


# Process entry points (main functions)
list(APPEND WebProcess_SOURCES
    WebProcess/EntryPoint/unix/WebProcessMain.cpp
)

list(APPEND NetworkProcess_SOURCES
    NetworkProcess/EntryPoint/unix/NetworkProcessMain.cpp
)

# Allow unresolved symbols in process executables for initial port
set(CMAKE_EXE_LINKER_FLAGS " -Wl,--unresolved-symbols=ignore-all")
