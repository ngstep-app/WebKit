list(APPEND PAL_PUBLIC_HEADERS
    crypto/gcrypt/Handle.h
    crypto/gcrypt/Initialization.h
    crypto/gcrypt/Utilities.h

    crypto/tasn1/Utilities.h
)

list(APPEND PAL_SOURCES
    crypto/gcrypt/CryptoDigestGCrypt.cpp

    crypto/tasn1/Utilities.cpp

    system/ClockGeneric.cpp
    system/Sound.cpp

    text/KillRing.cpp
)

list(APPEND PAL_LIBRARIES
    ${GNUSTEP_LIBRARIES}
    GLib::GLib
    Tasn1::Tasn1
)

list(APPEND PAL_SYSTEM_INCLUDE_DIRECTORIES
    ${GNUSTEP_INCLUDE_DIRS}
)
