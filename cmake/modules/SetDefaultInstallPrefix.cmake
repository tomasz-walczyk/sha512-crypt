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

function(set_default_install_prefix DEFAULT_INSTALL_PREFIX)
  if(${CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT})
    if(${DEFAULT_INSTALL_PREFIX} STREQUAL Auto)
      if(DEFINED ENV{INSTALL_PATH})
        if(NOT $ENV{INSTALL_PATH} STREQUAL Auto)
          set(CMAKE_INSTALL_PREFIX $ENV{INSTALL_PATH}
            CACHE PATH "Install path prefix, prepended onto install directories." FORCE)
        endif()
      endif()
    else()
      set(CMAKE_INSTALL_PREFIX ${DEFAULT_INSTALL_PREFIX}
        CACHE PATH "Install path prefix, prepended onto install directories." FORCE)
    endif()
  endif()
endfunction()
