# firebase_cmake
CMake Finder module for Firebase

This is an CMake module that helps to locate Firebase for your platform using find_package.

Usage examples from your CMake code:
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/firebase_cmake")

find_package(Firebase)

target_link_libraries(${project_name} firebase)
