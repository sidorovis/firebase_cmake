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
# Supported next components:
# 1. app
# 2. analytics
#

# root folder definition

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
    message(STATUS "[DEBUG]: We will look for firebase sdk at ${firebase_root} path")
endif()

set(firebase_FOUND TRUE)
set(firebase_INCLUDE_DIRS "")
set(firebase_LIBRARIES "")

# component list definition

set(components app analytics)

if (NOT ${firebase_FIND_COMPONENTS})
    if (firebase_FIND_DEBUG)
	message(STATUS "[DEBUG]: We will look for all possible components (${components})")
    endif()
    set(firebase_FIND_COMPONENTS ${components})
endif()

set(firebase_LIBRARIES_FOLDER folder-NOTFOUND)

if(UNIX AND NOT APPLE AND NOT CYGWIN)
    set(firebase_LIBRARIES_FOLDER "${firebase_root}/libs/linux")
else()
    message(FATAL_ERROR "Not supported (yet) architecture / operation system / compiler")
endif()

if (firebase_FIND_DEBUG)
    message(STATUS "[DEBUG]: Path that we will look for libraries is ${firebase_LIBRARIES_FOLDER}")
endif()

# component dependency resolve

list(FIND firebase_FIND_COMPONENTS app firebase_app_found)
list(FIND firebase_FIND_COMPONENTS analytics firebase_analytics_found)
if ((("${firebase_analytics_found}" GREATER "-1")) AND (NOT ("${firebase_app_found}" GREATER "-1")))
    if (firebase_FIND_DEBUG)
        message(STATUS "[DEBUG]: Component 'analytics' found into {find component list}, so 'app' should also get to the list.")
    endif()
    set(firebase_FIND_COMPONENTS app ${firebase_FIND_COMPONENTS})
    list(FIND firebase_FIND_COMPONENTS app firebase_app_found)
endif()

if (firebase_FIND_DEBUG)
    message(STATUS "[DEBUG]: Actual components list (after dependencies resolve): ${firebase_FIND_COMPONENTS}")
endif()

# paths search

foreach(component ${firebase_FIND_COMPONENTS})
    list(FIND components "${component}" we_should_find_${component})
    if (firebase_FIND_DEBUG)
	message(STATUS "[DEBUG]: We are looking for firebase '${component}' component and index into existing components list is ${we_should_find_${component}}")
    endif()
    if (NOT "${we_should_find_${component}}" GREATER "-1")
	if (firebase_FIND_REQUIRED)
	    message(FATAL_ERROR "Unknown firebase component '${component}' was added to find_package command")
	elseif(firebase_FIND_DEBUG)
	    message(WARNING "[DEBUG]: ${component} component is not in a list of available components")
	    continue()
	endif()
    endif()

    set(firebase_${component}_FOUND FALSE)
    set(firebase_${component}_INCLUDE_DIRS ${component}-NOTFOUND)
    set(firebase_${component}_LIBRARIES ${component}-NOTFOUND)

    find_path(firebase_${component}_INCLUDE_DIRS
		NAMES "${component}.h"
		HINTS "${firebase_root}/include/firebase")

    find_library(firebase_${component}_LIBRARIES
		NAMES "${component}"
		HINTS "${firebase_LIBRARIES_FOLDER}")

    if (NOT firebase_FIND_QUIETLY)
	message(STATUS "Firebase ${component} header path: '${firebase_${component}_INCLUDE_DIRS}'")
	message(STATUS "Firebase ${component} libraries: '${firebase_${component}_LIBRARY}'")
    endif()

    if (NOT firebase_${component}_INCLUDE_DIRS)
	if (firebase_FIND_REQUIRED)
	    message(FATAL_ERROR "Firebase ${component} component header was not found")
	endif()
	set(firebase_FOUND FALSE)
    endif()

    if (NOT firebase_${component}_LIBRARIES)
	if (firebase_FIND_REQUIRED)
		message(FATAL_ERROR "Firebase ${component} component library was not found")
	endif()
	set(firebase_FOUND FALSE)
    endif()

    if (firebase_${component}_INCLUDE_DIRS AND firebase_${component}_LIBRARIES)
	set(firebase_INCLUDE_DIRS ${firebase_INCLUDE_DIRS} ${firebase_${component}_INCLUDE_DIRS})
	set(firebase_LIBRARIES ${firebase_LIBRARIES} ${firebase_${component}_LIBRARIES})
	set(firebase_${component}_FOUND TRUE)
    endif()

endforeach()

list(REMOVE_DUPLICATES firebase_INCLUDE_DIRS)
list(REMOVE_DUPLICATES firebase_LIBRARIES)

