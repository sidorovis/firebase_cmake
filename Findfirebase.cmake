#
# This is a CMake finder module for Firebase project (http://firebase.google.com/)
#
# Requirements: 
# 1. firebase_ROOT (example: set(firebase_ROOT ~/firebase_cpp_sdk));
# OR 
# 2. environment variable FIREBASE_ROOT should exists.
#

if (firebase_ROOT)
    set(firebase_root ${firebase_ROOT})
elseif(NOT "$ENV{FIREBASE_ROOT}" STREQUAL "")
    set(firebase_root $ENV{FIREBASE_ROOT})
else()
    if (firebase_REQUIRED)
        message(FATAL_ERROR "No firebase_ROOT OR \$ENV\{FIREBASE_ROOT\} variable found.")
    else()
        message(WARNING "No firebase_ROOT OR \$ENV\{FIREBASE_ROOT\} variable found.")
        return()
    endif()
endif()

