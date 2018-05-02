# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

cmake_minimum_required(VERSION 3.4.1)

file(GLOB game_srcs
        "src/main/Quake2/Sources/game/*.c"
        "src/main/Quake2/Sources/game/player/*.c"
        "src/main/Quake2/Sources/game/monster/*/*.c"
        "src/main/Quake2/Sources/game/savegame/savegame.c"
        "src/main/Quake2/Sources/common/shared/*.c"
    )
add_library(game
    SHARED
    ${game_srcs})

file(GLOB quake2_srcs
        "src/main/Quake2/Sources/server/*.c"
        "src/main/Quake2/Sources/client/*.c"
        "src/main/Quake2/Sources/client/refresh/*.c"
        "src/main/Quake2/Sources/client/refresh/files/*.c"
        "src/main/Quake2/Sources/client/menu/*.c"
        "src/main/Quake2/Sources/client/sound/*.c"
        "src/main/Quake2/Sources/common/*.c"
        "src/main/Quake2/Sources/common/shared/*.c"
        "src/main/Quake2/Sources/common/unzip/*.c"
        "src/main/Quake2/Sources/backends/*.c"
        "src/main/Quake2/Sources/backends/android/*.c"
        "src/main/Quake2/OpenGLES/*.c"
        "src/main/Quake2/Android/*.cc"
     )
add_library(quake2
    SHARED
    ${quake2_srcs})

include_directories(
        "src/main/Quake2/Sources"
        "src/main/Quake2"
        "src/main/Quake2/zlib"
        "src/main/Quake2/zlib/contrib/minizip"
    )

# Include the GVR headers & libraries.
include_directories(${GVR_INCLUDE})

add_library(gvr-lib SHARED IMPORTED)
set_target_properties(
    gvr-lib
    PROPERTIES IMPORTED_LOCATION ${GVR_LIBPATH}/${ANDROID_ABI}/libgvr.so)

add_library(gvraudio-lib SHARED IMPORTED)
set_target_properties(
    gvraudio-lib
    PROPERTIES IMPORTED_LOCATION ${GVR_LIBPATH}/${ANDROID_ABI}/libgvr_audio.so)

# Build final
target_link_libraries(quake2
    game
    gvr-lib
    gvraudio-lib

    dl
    z
    android
    EGL
    GLESv2
    log
    )

