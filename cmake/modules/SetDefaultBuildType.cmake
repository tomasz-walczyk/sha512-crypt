#
# Copyright (C) 2022 Tomasz Walczyk
#
# This software may be modified and distributed under the terms
# of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
# See the LICENSE file for details.
#
############################################################

include_guard()

############################################################

function(set_default_build_type DEFAULT_BUILD_TYPE)
  if(CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_CONFIGURATION_TYPES ${CMAKE_CONFIGURATION_TYPES}
      CACHE STRING "Semicolon separated list of supported configuration types (Debug, Release, MinSizeRel or RelWithDebInfo)." FORCE)
  else()
    if(NOT CMAKE_BUILD_TYPE)
      set(_SUPPORTED_BUILD_TYPES Auto Debug Release MinSizeRel RelWithDebInfo)
      if(NOT ${DEFAULT_BUILD_TYPE} IN_LIST _SUPPORTED_BUILD_TYPES)
        message(FATAL_ERROR "Unsupported build type: ${DEFAULT_BUILD_TYPE}")
      endif()
      set(_DEFAULT_BUILD_TYPE ${DEFAULT_BUILD_TYPE})
      if(${_DEFAULT_BUILD_TYPE} STREQUAL Auto)
        if(DEFINED ENV{BUILD_TYPE})
          if($ENV{BUILD_TYPE} IN_LIST _SUPPORTED_BUILD_TYPES)
            set(_DEFAULT_BUILD_TYPE $ENV{BUILD_TYPE})
          else()
            message(FATAL_ERROR "Unsupported build type: $ENV{BUILD_TYPE}")
          endif()
        endif()
      endif()
      if(${_DEFAULT_BUILD_TYPE} STREQUAL Auto)
        set(_GIT_DIRECTORY ${CMAKE_SOURCE_DIR}/.git)
        if(EXISTS ${_GIT_DIRECTORY} AND IS_DIRECTORY ${_GIT_DIRECTORY})
          set(_DEFAULT_BUILD_TYPE Debug)
        else()
          set(_DEFAULT_BUILD_TYPE Release)
        endif()
      endif()
      set(CMAKE_BUILD_TYPE ${_DEFAULT_BUILD_TYPE}
        CACHE STRING "Type of the build (Debug, Release, MinSizeRel or RelWithDebInfo)." FORCE)
    endif()
  endif()
endfunction()
