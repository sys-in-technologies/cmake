find_package(PkgConfig)
pkg_check_modules(PKG_mosquitto libmosquitto)

set(mosquitto_DEFINITIONS ${PKG_mosquitto_CFLAGS_OTHER})
set(mosquitto_VERSION ${PKG_mosquitto_VERSION})

find_path(mosquitto_INCLUDE_DIR
    NAMES
        mosquitto.h
    HINTS
        ${PKG_mosquitto_INCLUDE_DIRS}
)
find_library(mosquitto_LIBRARY
    NAMES
        mosquitto
    HINTS
        ${PKG_mosquitto_LIBRARY_DIRS}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(mosquitto
    FOUND_VAR
        mosquitto_FOUND
    REQUIRED_VARS
        mosquitto_LIBRARY
        mosquitto_INCLUDE_DIR
    VERSION_VAR
        mosquitto_VERSION
)

if(mosquitto_FOUND AND NOT TARGET mosquitto::libmosquitto)
    add_library(mosquitto::libmosquitto UNKNOWN IMPORTED)
    set_target_properties(mosquitto::libmosquitto PROPERTIES
        IMPORTED_LOCATION "${mosquitto_LIBRARY}"
        INTERFACE_COMPILE_OPTIONS "${mosquitto_DEFINITIONS}"
        INTERFACE_INCLUDE_DIRECTORIES "${mosquitto_INCLUDE_DIR}"
    )
endif()

mark_as_advanced(mosquitto_LIBRARY mosquitto_INCLUDE_DIR)
set(mosquitto_VERSION_STRING ${mosquitto_VERSION})