cmake_minimum_required(VERSION 3.15)

PROJECT(JUCE_CMAKE_ANDROID_EXAMPLE
LANGUAGES C CXX
VERSION 0.0.1
)

# for clang-tidy(this enable to find system header files).
if(CMAKE_EXPORT_COMPILE_COMMANDS)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()

if (ANDROID)
if ("${JUCE_DIR}" STREQUAL "")
set (JUCE_DIR "JUCE")
endif ()
set (OBOE_DIR "${JUCE_DIR}//modules/juce_audio_devices/native/oboe")

# defs, some are specific to Android and need definisions in prior to `add_subdirectory(JUCE)`.
add_definitions(
    "-DJUCE_ANDROID=1"
    "-DJUCE_ANDROID_API_VERSION=16"
    "-DJUCE_PUSH_NOTIFICATIONS=1" 
    "-DJUCE_PUSH_NOTIFICATIONS_ACTIVITY=\"com/rmsl/juce/JuceActivity\"" 
    "-DJUCE_USE_ANDROID_OBOE=0"
    )

# Enable these lines if you use juce_audio_devices API
set(JUCE_USE_ANDROID_OBOE 1)
set(OBOE_DIR "${JUCE_DIR}/modules/juce_audio_devices/native/oboe")
#add_subdirectory (${OBOE_DIR} ./oboe)

# libcpufeatures

add_library("cpufeatures" STATIC "${ANDROID_NDK}/sources/android/cpufeatures/cpu-features.c")
set_source_files_properties("${ANDROID_NDK}/sources/android/cpufeatures/cpu-features.c" PROPERTIES COMPILE_FLAGS "-Wno-sign-conversion -Wno-gnu-statement-expression")

enable_language(ASM)

endif (ANDROID)

# build App code (e.g. libExamplePlugin_Standalone.so)

add_subdirectory("../../../../external/LMN-3-DAW" ./LMN-3-DAW)

if (ANDROID)

add_library(juce_jni
    SHARED
    dummy.cpp
    )

target_link_libraries(juce_jni
    ${target_name}
)

target_compile_options(juce_jni PRIVATE "-fsigned-char" )

endif (ANDROID)
