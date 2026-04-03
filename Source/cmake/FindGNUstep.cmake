# FindGNUstep.cmake - Detect GNUstep installation
# Sets: GNUSTEP_FOUND, GNUSTEP_INCLUDE_DIRS, GNUSTEP_LIBRARIES, GNUSTEP_FLAGS

find_program(GNUSTEP_CONFIG gnustep-config
    PATHS /System/Library/Tools /usr/local/bin /usr/bin
    NO_DEFAULT_PATH
)

if (NOT GNUSTEP_CONFIG)
    find_program(GNUSTEP_CONFIG gnustep-config)
endif ()

if (GNUSTEP_CONFIG)
    execute_process(
        COMMAND ${GNUSTEP_CONFIG} --objc-flags
        OUTPUT_VARIABLE GNUSTEP_OBJC_FLAGS
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    execute_process(
        COMMAND ${GNUSTEP_CONFIG} --objc-libs
        OUTPUT_VARIABLE GNUSTEP_OBJC_LIBS
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    execute_process(
        COMMAND ${GNUSTEP_CONFIG} --gui-libs
        OUTPUT_VARIABLE GNUSTEP_GUI_LIBS
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    execute_process(
        COMMAND ${GNUSTEP_CONFIG} --variable=GNUSTEP_SYSTEM_HEADERS
        OUTPUT_VARIABLE GNUSTEP_SYSTEM_HEADERS
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    execute_process(
        COMMAND ${GNUSTEP_CONFIG} --variable=GNUSTEP_SYSTEM_LIBRARIES
        OUTPUT_VARIABLE GNUSTEP_SYSTEM_LIBRARIES
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    set(GNUSTEP_FOUND TRUE)
    set(GNUSTEP_INCLUDE_DIRS ${GNUSTEP_SYSTEM_HEADERS})
    set(GNUSTEP_LIBRARY_DIRS ${GNUSTEP_SYSTEM_LIBRARIES})

    # Find individual libraries
    find_library(GNUSTEP_BASE_LIBRARY gnustep-base PATHS ${GNUSTEP_SYSTEM_LIBRARIES} NO_DEFAULT_PATH)
    find_library(GNUSTEP_GUI_LIBRARY gnustep-gui PATHS ${GNUSTEP_SYSTEM_LIBRARIES} NO_DEFAULT_PATH)
    find_library(OBJC2_LIBRARY objc PATHS ${GNUSTEP_SYSTEM_LIBRARIES} NO_DEFAULT_PATH)
    find_library(DISPATCH_LIBRARY dispatch PATHS ${GNUSTEP_SYSTEM_LIBRARIES} /usr/lib NO_DEFAULT_PATH)

    set(GNUSTEP_LIBRARIES
        ${GNUSTEP_BASE_LIBRARY}
        ${GNUSTEP_GUI_LIBRARY}
        ${OBJC2_LIBRARY}
    )
    if (DISPATCH_LIBRARY)
        list(APPEND GNUSTEP_LIBRARIES ${DISPATCH_LIBRARY})
    endif ()

    message(STATUS "Found GNUstep: ${GNUSTEP_CONFIG}")
    message(STATUS "  Headers: ${GNUSTEP_INCLUDE_DIRS}")
    message(STATUS "  Libraries: ${GNUSTEP_LIBRARY_DIRS}")
else ()
    # Fallback: check known paths
    if (EXISTS "/System/Library/Makefiles/GNUstep.sh")
        set(GNUSTEP_FOUND TRUE)
        set(GNUSTEP_INCLUDE_DIRS /System/Library/Headers)
        set(GNUSTEP_LIBRARY_DIRS /System/Library/Libraries)
        find_library(GNUSTEP_BASE_LIBRARY gnustep-base PATHS /System/Library/Libraries NO_DEFAULT_PATH)
        find_library(GNUSTEP_GUI_LIBRARY gnustep-gui PATHS /System/Library/Libraries NO_DEFAULT_PATH)
        find_library(OBJC2_LIBRARY objc PATHS /System/Library/Libraries NO_DEFAULT_PATH)
        find_library(DISPATCH_LIBRARY dispatch PATHS /System/Library/Libraries /usr/lib)
        set(GNUSTEP_LIBRARIES ${GNUSTEP_BASE_LIBRARY} ${GNUSTEP_GUI_LIBRARY} ${OBJC2_LIBRARY})
        if (DISPATCH_LIBRARY)
            list(APPEND GNUSTEP_LIBRARIES ${DISPATCH_LIBRARY})
        endif ()
        set(GNUSTEP_OBJC_FLAGS "-fobjc-runtime=gnustep-2.2 -fblocks -fconstant-string-class=NSConstantString")
        message(STATUS "Found GNUstep at /System/Library (fallback)")
    else ()
        set(GNUSTEP_FOUND FALSE)
        if (GNUstep_FIND_REQUIRED)
            message(FATAL_ERROR "GNUstep not found. Install GNUstep or set gnustep-config in PATH.")
        endif ()
    endif ()
endif ()
