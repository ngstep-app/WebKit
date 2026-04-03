
if (ENABLE_REMOTE_INSPECTOR)
    include(inspector/remote/Socket.cmake)
else ()
    list(REMOVE_ITEM JavaScriptCore_SOURCES
        inspector/JSGlobalObjectInspectorController.cpp
    )
endif ()


list(APPEND JavaScriptCore_LIBRARIES
    ${GNUSTEP_LIBRARIES}
)

list(APPEND JavaScriptCore_SYSTEM_INCLUDE_DIRECTORIES
    ${GNUSTEP_INCLUDE_DIRS}
)
