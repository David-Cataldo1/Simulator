cmake_minimum_required(VERSION 3.20)
project(Simulator LANGUAGES CXX CUDA)

set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -Wno-deprecated-gpu-targets")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CUDA_STANDARD 20)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# GLFW (FetchContent)
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

# Collect all .cpp, .cu, and .h files in src/
file(GLOB_RECURSE SRC_FILES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cu"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cuh"  
)

# Group source files in IDEs like Visual Studio by their physical folder
source_group(TREE "${CMAKE_CURRENT_SOURCE_DIR}/src" FILES ${SRC_FILES})

# Executable target with CUDA support
add_executable(Simulator ${SRC_FILES})

# Include directories
target_include_directories(Simulator PRIVATE
    src
    include
    external/glm
    external/stb
    external/entt
    external/spdlog
    external/glad/include
    ${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES} # CUDA headers
)

# Link libraries
target_link_libraries(Simulator PRIVATE
    glfw
    glad
    opengl32
)

# Optional: Target GPU architecture
set(CMAKE_CUDA_ARCHITECTURES 75)  # 75 = Turing (RTX 2070/3070)

# Ensure .cu files are compiled as CUDA, not C++
set_source_files_properties(${SRC_FILES} PROPERTIES LANGUAGE CUDA)

# Set as startup project in Visual Studio
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT Simulator)
