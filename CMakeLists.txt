cmake_minimum_required(VERSION 3.20)
project(Simulator)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Dependencies
include(FetchContent)

# GLFW
FetchContent_Declare(
  glfw
  GIT_REPOSITORY https://github.com/glfw/glfw.git
  GIT_TAG        3.3.8
)
FetchContent_MakeAvailable(glfw)

# GLM
FetchContent_Declare(
  glm
  GIT_REPOSITORY https://github.com/g-truc/glm.git
  GIT_TAG        0.9.9.9
)
FetchContent_MakeAvailable(glm)

# stb
FetchContent_Declare(
  stb
  GIT_REPOSITORY https://github.com/nothings/stb.git
)
FetchContent_MakeAvailable(stb)

# EnTT
FetchContent_Declare(
  entt
  GIT_REPOSITORY https://github.com/skypjack/entt.git
  GIT_TAG        v3.12.2
)
FetchContent_MakeAvailable(entt)

# GLAD (manual)
add_library(glad STATIC external/glad/src/glad.c)
target_include_directories(glad PUBLIC external/glad/include)

# Executable
add_executable(Simulator
    src/main.cpp
)

# Includes
target_include_directories(Simulator PRIVATE include)

# Link libraries
target_link_libraries(Simulator PRIVATE glad glfw)

# Include header-only libs
target_include_directories(Simulator PRIVATE
    ${glm_SOURCE_DIR}
    ${stb_SOURCE_DIR}
    ${entt_SOURCE_DIR}/single_include
)
