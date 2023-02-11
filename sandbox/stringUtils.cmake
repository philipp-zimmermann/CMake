# appends a string multiple times to the value of str_variable
#
# @str_variable The variable (not its value!) that holds the base string
# @appendage The string (Yes the value) that is to be appended
# @amount The amount of times the appendage is to be appended
function (append_n_chars str_variable appendage amount)
  math(EXPR amount_decreased "${amount}-1")
  # TODO: replace this with string(REPEAT <args>) with version > 3.15
  foreach(i RANGE ${amount_decreased})
    string(APPEND ${str_variable} ${appendage})
  endforeach()
  set(${str_variable} ${${str_variable}} PARENT_SCOPE)
endfunction()


include(${CMAKE_CURRENT_SOURCE_DIR}/LoggingUtils/colorCodes.cmake)

# calculates the lenght of an input_string without counting the ASCII color escape code
# defined in colorCades.cmake
function(str_length_without_ANSI_esc input_string output_variable)
  #trims color escape codes from input
  string(REGEX REPLACE ${esc_regex} "" trimmed_string ${input_string})
  if(NOT ${trimmed_string} STREQUAL "")
    string(LENGTH ${trimmed_string} trimmed_string_length)
  else()
    set(trimmed_string_length 0)
  endif()
  set(${output_variable} ${trimmed_string_length} PARENT_SCOPE)
endfunction()
