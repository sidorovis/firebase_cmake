#
# This is a CMake finder module for Firebase project (http://firebase.google.com/)
#
# Requirements: 
# 1. firebase_ROOT (FIREBASE_ROOT also acceptable) for example: set(firebase_ROOT ~/firebase_cpp_sdk);
# OR 
# 2. environment variable FIREBASE_ROOT should exists.
#
# Optional variables:
# 1. firebase_FIND_DEBUG - will generate much bigger amount of messages and will help to debug find firebase process.
#
# Output variables and search paths are:
# 1. firebase_FOUND (FALSE, TRUE);
# 2. firebase_INCLUDE_DIRS (list of folders where firebase sdk headers are situated);
# 3. firebase_LIBRARIES (list of paths to the installed libraries).
#


if (firebase_ROOT)
    set(firebase_root ${firebase_ROOT})
elseif(FIREBASE_ROOT)
    set(firebase_root ${FIREBASE_ROOT})
elseif(NOT "$ENV{FIREBASE_ROOT}" STREQUAL "")
    set(firebase_root $ENV{FIREBASE_ROOT})
else()
    if (firebase_FIND_REQUIRED)
        message(FATAL_ERROR "No firebase_ROOT OR \$ENV\{FIREBASE_ROOT\} variable found.")
    else()
        message(WARNING "No firebase_ROOT OR \$ENV\{FIREBASE_ROOT\} variable found.")
        return()
    endif()
endif()

if (firebase_FIND_DEBUG)
    message(STATUS "We will look for firebase sdk at ${firebase_root} path")
endif()

