cmake_minimum_required(VERSION 3.20)

include(FetchContent)

project(Main LANGUAGES CUDA CXX)

if(NOT DEFINED CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

if(NOT DEFINED CMAKE_CUDA_STANDARD)
    set(CMAKE_CUDA_STANDARD 17)
    set(CMAKE_CUDA_STANDARD_REQUIRED ON)
endif()

# Ecuda dependency (header only library)

FetchContent_Declare(
    ecuda
    GIT_REPOSITORY    "https://github.com/lattice-land/ecuda.git"
    GIT_TAG           6a004ad11c7d938b0c247d474a2f733d6aa71499
)

FetchContent_GetProperties(ecuda)
if(NOT ecuda_POPULATED)
    FetchContent_Populate(ecuda)
    include_directories("${ecuda_SOURCE_DIR}/include")
endif()

# Executable

add_executable(main src/main.cu)

add_compile_options(main
    PRIVATE
    $<$<COMPILE_LANGUAGE:CXX>:-Wall>
    $<$<COMPILE_LANGUAGE:CUDA>:--expt-relaxed-constexpr -rdc=true -arch=sm_75>
    $<$<CONFIG:Debug>:-g -G -DDEBUG>
    $<$<CONFIG:Release>:-O3>
)
