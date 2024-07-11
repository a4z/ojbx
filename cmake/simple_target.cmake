include_guard(GLOBAL)

enable_testing()

function(bin_from_file fname)

    set(option_args "")
    set(value_args OUT) # unsused until I do stuff below
    set(list_args LINK)

    cmake_parse_arguments(B_FROM_F
        "${option_args}"
        "${value_args}"
        "${list_args}"
        ${ARGN}
    )

    get_filename_component(bname ${fname} NAME_WE)
    set(${outname} ${bname} PARENT_SCOPE)
    add_executable(${bname} ${fname})
    target_link_libraries (${bname}
        PRIVATE ${B_FROM_F_LINK}
    )
endfunction(bin_from_file)


