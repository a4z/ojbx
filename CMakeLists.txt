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

