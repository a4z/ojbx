

find_program(OBJECTBOX_GENERATOR objectbox-generator)

if(NOT OBJECTBOX_GENERATOR)
  message(FATAL_ERROR "objectbox-generator not found")
else()
  MESSAGE(STATUS "Found objectbox-generator: ${OBJECTBOX_GENERATOR}")
endif()


file(GLOB FBS_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.fbs)
add_library(fbs STATIC)

message("Remove existing generated files")
execute_process(
  COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_CURRENT_LIST_DIR}/generated
  WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
#  COMMAND_ERROR_IS_FATAL LAST
  #COMMAND_ECHO STDOUT
)

file(MAKE_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/generated)

foreach(fbs_file ${FBS_FILES})
  set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS
    ${fbs_file}
  )

  message("Generating objectbox files for ${name}")
  execute_process(
#    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_CURRENT_LIST_DIR}/${out}
    COMMAND objectbox-generator -cpp -out ${CMAKE_CURRENT_LIST_DIR}/generated ${fbs_file}
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    COMMAND_ERROR_IS_FATAL LAST
    COMMAND_ECHO STDOUT
  )

endforeach()

file(GLOB FBS_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/generated/*.cpp)
target_sources(fbs PRIVATE ${FBS_SOURCE_FILES})
target_include_directories(fbs PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/generated)
target_link_libraries(fbs PUBLIC flatbuffers::flatbuffers objectbox)
