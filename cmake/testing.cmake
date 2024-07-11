include_guard(GLOBAL)

find_package(Catch2 3 REQUIRED)
#include(CTest)
enable_testing()


function (catch_test NAME)

    set(option_args WILL_FAIL) # Seems not to work ....
    set(value_args TIMEOUT)
    set(list_args SOURCES)

    cmake_parse_arguments(D_TEST
        "${option_args}" "${value_args}" "${list_args}"
        ${ARGN}
    )

    add_executable(${NAME} ${D_TEST_SOURCES})
    target_link_libraries(${NAME} PRIVATE Catch2::Catch2WithMain psys3)
    #target_link_libraries(${NAME} PRIVATE Catch2::Catch2WithMain)

    if(NOT D_TEST_TIMEOUT)
        set(D_TEST_TIMEOUT 3)
    endif()
    if(NOT D_TEST_WILL_FAIL)
        set(D_TEST_WILL_FAIL OFF)
    endif()

    add_test(NAME ${NAME} COMMAND ${NAME})
    # add_test(NAME ${NAME} COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE=${NAME}.profraw ./${NAME})

    set_tests_properties(${NAME}
        PROPERTIES
            TIMEOUT ${D_TEST_TIMEOUT}
            WILL_FAIL ${D_TEST_WILL_FAIL}
            ENVIRONMENT "LLVM_PROFILE_FILE=${NAME}.profraw"
    )

endfunction(catch_test)




