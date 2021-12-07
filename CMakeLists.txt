#
# Copyright (C) 2022 Tomasz Walczyk
#
# This software may be modified and distributed under the terms
# of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
# See the LICENSE file for details.
#
############################################################

cmake_minimum_required(VERSION 3.20)

############################################################

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake/modules)

############################################################

if(APPLE)
  set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64"
    CACHE STRING "Build architectures for MacOS.")
  set(CMAKE_OSX_DEPLOYMENT_TARGET "11.5"
    CACHE STRING "Minimum MacOS version to target for deployment.")
endif()

project(sha512-crypt LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)

include(SetDefaultBuildType)
set_default_build_type(Auto)

include(SetDefaultInstallPrefix)
set_default_install_prefix(Auto)

if(MSVC)
  add_compile_options(/W4 /WX)
else()
  add_compile_options(-Wall -Wextra -Wpedantic -Werror)
endif()

if(MSVC)
  set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

add_subdirectory(lib)
add_subdirectory(bin)
add_subdirectory(test)
