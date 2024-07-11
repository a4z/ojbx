set(GCCN "14")

find_program(GCC_PATH gcc-${GCCN})
find_program(GPP_PATH g++-${GCCN})

if(NOT GCC_PATH)
    message(FATAL_ERROR "gcc-${GCCN} not found")
endif()

if(NOT GPP_PATH)
    message(FATAL_ERROR "g++-${GCCN} not found")
endif()

SET(CMAKE_C_COMPILER ${GCC_PATH})
SET(CMAKE_CXX_COMPILER ${GPP_PATH})

if (APPLE)
    set(CMAKE_EXE_LINKER_FLAGS "-Wl,-ld_classic")
endif()
