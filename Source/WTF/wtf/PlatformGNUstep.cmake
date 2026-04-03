set(WTF_OUTPUT_NAME WTFGNUstep)

list(APPEND WTF_SOURCES
    generic/MainThreadGeneric.cpp
    generic/WorkQueueGeneric.cpp

    glib/Application.cpp
    glib/ChassisType.cpp
    glib/FileSystemGlib.cpp
    glib/GMallocString.cpp
    glib/GRefPtr.cpp
    glib/GSocketMonitor.cpp
    glib/GSpanExtras.cpp
    glib/RunLoopGLib.cpp
    glib/Sandbox.cpp
    glib/SocketConnection.cpp


    posix/CPUTimePOSIX.cpp
    posix/FileHandlePOSIX.cpp
    posix/FileSystemPOSIX.cpp
    posix/MappedFileDataPOSIX.cpp
    posix/OSAllocatorPOSIX.cpp
    posix/ThreadingPOSIX.cpp

    text/unix/TextBreakIteratorInternalICUUnix.cpp

    unix/LanguageUnix.cpp
    unix/LoggingUnix.cpp
    unix/UniStdExtrasUnix.cpp
)

list(APPEND WTF_PUBLIC_HEADERS
    glib/ActivityObserver.h
    glib/Application.h
    glib/ChassisType.h
    glib/GMallocString.h
    glib/GRefPtr.h
    glib/GSocketMonitor.h
    glib/GSpanExtras.h
    glib/GThreadSafeWeakPtr.h
    glib/GTypedefs.h
    glib/GUniquePtr.h
    glib/GWeakPtr.h
    glib/RunLoopSourcePriority.h
    glib/Sandbox.h
    glib/SocketConnection.h
    glib/SysprofAnnotator.h
    glib/WTFGType.h

    linux/CurrentProcessMemoryStatus.h
    linux/ProcessMemoryFootprint.h
    linux/RealTimeThreads.h

    posix/SocketPOSIX.h

    unix/UnixFileDescriptor.h
)

if (CMAKE_SYSTEM_NAME MATCHES "Linux")
    list(APPEND WTF_SOURCES
        linux/CurrentProcessMemoryStatus.cpp
        linux/MemoryFootprintLinux.cpp
        linux/RealTimeThreads.cpp

        unix/MemoryPressureHandlerUnix.cpp
    )
endif ()

list(APPEND WTF_LIBRARIES
    ${GNUSTEP_LIBRARIES}
    GLib::Gio
    Threads::Threads
    ZLIB::ZLIB
    pthread
    dl
)

list(APPEND WTF_SYSTEM_INCLUDE_DIRECTORIES
    ${GNUSTEP_INCLUDE_DIRS}
)

# Enable ObjC/ObjC++ for GNUstep .mm files
set_property(TARGET WTF PROPERTY LINKER_LANGUAGE CXX)
