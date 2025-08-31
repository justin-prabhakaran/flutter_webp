cmake_minimum_required(VERSION 3.10)

project(flutter_webp LANGUAGES CXX)

set(PLUGIN_NAME "flutter_webp_plugin")

set(PLUGIN_SOURCES
        "flutter_webp_plugin.cc"
)

add_library(${PLUGIN_NAME} SHARED
        ${PLUGIN_SOURCES}
)

# Apply Flutter standard build settings
apply_standard_settings(${PLUGIN_NAME})

# Set visibility and plugin implementation flag
set_target_properties(${PLUGIN_NAME} PROPERTIES
        CXX_VISIBILITY_PRESET hidden
)
target_compile_definitions(${PLUGIN_NAME} PRIVATE FLUTTER_PLUGIN_IMPL)

# Include paths and link to Flutter
target_include_directories(${PLUGIN_NAME} INTERFACE
        "${CMAKE_CURRENT_SOURCE_DIR}/include"
)
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter)

# Link GTK since Flutter Linux apps need it
target_link_libraries(${PLUGIN_NAME} PRIVATE PkgConfig::GTK)

set(MY_PLUGIN_LIBS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libs")

target_link_libraries(${PLUGIN_NAME} PRIVATE
    "${MY_PLUGIN_LIBS_DIR}/libwebp.so"
)