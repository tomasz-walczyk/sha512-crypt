#
# Copyright (C) 2022 Tomasz Walczyk
#
# This software may be modified and distributed under the terms
# of the GNU LESSER GENERAL PUBLIC LICENSE VERSION 3.0.
# See the LICENSE file for details.
#
############################################################

add_executable(${PROJECT_NAME}-bin source/main.cpp)
set_target_properties(${PROJECT_NAME}-bin PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
target_link_libraries(${PROJECT_NAME}-bin PRIVATE ${PROJECT_NAME}-lib)
install(TARGETS ${PROJECT_NAME}-bin DESTINATION bin)
