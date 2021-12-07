#
# Copyright (C) 2022 Tomasz Walczyk
#
# This software may be modified and distributed under the terms
# of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
# See the LICENSE file for details.
#
############################################################

add_library(${PROJECT_NAME}-lib STATIC include/${PROJECT_NAME}/sha512-crypt.hpp source/sha512-crypt.cpp)
set_target_properties(${PROJECT_NAME}-lib PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
target_include_directories(${PROJECT_NAME}-lib PUBLIC include)
install(TARGETS ${PROJECT_NAME}-lib DESTINATION lib)
install(DIRECTORY include/ DESTINATION include)
