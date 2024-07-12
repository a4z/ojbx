cmake_minimum_required(VERSION 3.28)
project(myapp)

include(FetchContent)
FetchContent_Declare(
    objectbox
    GIT_REPOSITORY https://github.com/objectbox/objectbox-c.git
    GIT_TAG        v4.0.0
    OVERRIDE_FIND_PACKAGE
)

find_package(objectbox CONFIG REQUIRED)



find_package(flatbuffers CONFIG REQUIRED)
add_subdirectory(fbs)

add_executable(myapp main.cpp)
target_link_libraries(myapp objectbox fbs)

if(WIN32)
    file(GLOB_RECURSE OBJECTBOX_DLL ${CMAKE_BINARY_DIR}/_deps/objectbox-download-src/*objectbox.dll)
    # that is probably not 100% the best solution, but higlights the point
    if(CMAKE_CONFIGURATION_TYPES)
        foreach(config ${CMAKE_CONFIGURATION_TYPES})
            set(app_RUNTIME_DIR "${CMAKE_CURRENT_BINARY_DIR}/${config}")
            file(COPY ${OBJECTBOX_DLL} DESTINATION ${app_RUNTIME_DIR})
        endforeach()
    else()
        set(app_RUNTIME_DIR "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}")
        file(COPY ${OBJECTBOX_DLL} DESTINATION ${app_RUNTIME_DIR})
    endif()
endif(WIN32)

