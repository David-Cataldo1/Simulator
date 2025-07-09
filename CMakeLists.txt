cmake_minimum_required(VERSION 3.20)
project(Simulator)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# GLFW (the only one we'll fetch)
include(FetchContent)
FetchContent_Declare(
  glfw
  GIT_REPOSITORY https://github.com/glfw/glfw.git
  GIT_TAG        3.3.8
)
FetchContent_MakeAvailable(glfw)

# GLAD (manual add)
add_library(glad STATIC external/glad/src/glad.c)
target_include_directories(glad PUBLIC external/glad/include)


# Collect all sources
file(GLOB_RECURSE SRC_FILES CONFIGURE_DEPENDS
    src/*.cpp
    src/*.h
)

# Organize files in folders (Visual Studio only)
foreach(FILE ${SRC_FILES})
    get_filename_component(PARENT_DIR "${FILE}" DIRECTORY)
    string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/src/" "" GROUP "${PARENT_DIR}")
    string(REPLACE "/" "\\" GROUP "${GROUP}")
    source_group("${GROUP}" FILES "${FILE}")
endforeach()

# Define executable
add_executable(Simulator ${SRC_FILES})

# Include directories
target_include_directories(Simulator PRIVATE
    include
    external/glm
    external/stb
    external/entt
    external/spdlog
)

# Link libraries
target_link_libraries(Simulator PRIVATE glfw glad)
