# firebase_cmake
CMake Finder module for Firebase (http://firebase.google.com/)

--------------

# Requirements:

1. firebase_ROOT (FIREBASE_ROOT also acceptable) for example: set(firebase_ROOT ~/firebase_cpp_sdk);
OR.
2. environment variable FIREBASE_ROOT should exists.


# Optional variables:

1. firebase_FIND_DEBUG - will generate much bigger amount of messages and will help to debug find firebase process.


# Output variables and search paths are:

1. firebase_FOUND (FALSE, TRUE);
2. firebase_INCLUDE_DIRS (list of folders where firebase sdk headers are situated);
3. firebase_LIBRARIES (list of paths to the installed libraries).


# Supported components:

1. app
2. analytics

Usage examples from your CMake code:
```
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/firebase_cmake")
find_package(firebase QUIET REQUIRED COMPONENTS app analytics)
target_link_libraries(${project_name} firebase)
```