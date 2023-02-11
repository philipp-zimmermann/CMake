include (${CMAKE_CURRENT_SOURCE_DIR}/LoggingUtils/stringUtils.cmake)

function(print_box_top width variant)
  set(msg_line ${box_top_left_${variant}})
  math(EXPR amount_decreased "${width} - 2")
  append_n_chars(msg_line ${box_horizontal_${variant}} ${amount_decreased})
  string(APPEND msg_line ${box_top_right_${variant}})
  message(STATUS ${msg_line})
endfunction()

function(print_box_bottom width variant)
  set(msg_line ${box_bottom_left_${variant}})
  math(EXPR amount_decreased "${width} - 2")
  append_n_chars(msg_line ${box_horizontal_${variant}} ${amount_decreased})
  string(APPEND msg_line ${box_bottom_right_${variant}})
  message(STATUS ${msg_line})
endfunction()

# print_box_text(<printed_string> <overall_box_width> <box_type>)
function(print_box_text str_value width variant)
  set(msg_line "${box_vertical_${variant}} ${str_value}")
  str_length_without_ANSI_esc(${msg_line} string_length)
  math(EXPR padding_size "${width} - ${string_length}")
  if(padding_size GREATER 0)
    append_n_chars(msg_line " " ${padding_size})
  else()
    message(AUTHOR_WARNING "box size is to small to encompass message: [${str_value}]")
  endif()
  string(APPEND msg_line " ${box_vertical_${variant}}")
  message(STATUS ${msg_line})
endfunction()


# print_box_vertical_divider(<overall_width> <outer_box_variant> [DASHED|LIGHT])
#   option DASHED       the devider will be printed as a dashed line
#   option LIGHT        the devider will be printed as a continous light line
#   <no option passed>  the devider will have the same variant as <outer_box_variant>
function(print_box_vertical_divider width box_variant)
  set(options DASHED LIGHT)
  cmake_parse_arguments(PARSE_ARGV 2 FUNC_ARG "${options}" "" "")
  if(NOT ${FUNC_ARG_UNPARSED_ARGUMENTS} STREQUAL "")
    message(AUTHOR_WARNING "unparsed arguments: " ${func_arg_UNPARSED_ARGUMENTS})
  endif()

  if(FUNC_ARG_LIGHT)
    set(divider_variant "light")
    set(fill_character ${light_line})
  elseif(FUNC_ARG_DASHED)
    set(divider_variant "light")
    set(fill_character ${light_line_dashed})
  else()
    set(divider_variant "box")
    set(fill_character ${box_horizontal_${box_variant}})
  endif()

  set(msg_line ${${divider_variant}_divider_left_${box_variant}})
  math(EXPR amount_decreased "${width} - 2")
  append_n_chars(msg_line ${fill_character} ${amount_decreased})
  string(APPEND msg_line ${${divider_variant}_divider_right_${box_variant}})
  message(STATUS ${msg_line})
endfunction()

function (getListOfVarsStartingWith _prefix _varResult)
    get_cmake_property(_vars VARIABLES)
    string (REGEX MATCHALL "(^|;)${_prefix}[A-Za-z0-9_]*" _matchedVars "${_vars}")
    set (${_varResult} ${_matchedVars} PARENT_SCOPE)
endfunction()


# getListOfVarsStartingWith(FUNC_ARG func_args)
# foreach (_var IN LISTS func_args)
#   message("${_var}=${${_var}}")
# endforeach()

##__UNICODE_box_characters________________________________________________________________

set(box_top_left_light "┌")
set(box_top_right_light "┐")
set(box_bottom_left_light "└")
set(box_bottom_right_light "┘")
set(box_horizontal_light "─")
set(box_vertical_light "│")

set(box_top_left_heavy "┏")
set(box_top_right_heavy "┓")
set(box_bottom_left_heavy "┗")
set(box_bottom_right_heavy "┛")
set(box_horizontal_heavy "━")
set(box_vertical_heavy "┃")

set(box_top_left_double "╔")
set(box_top_right_double "╗")
set(box_bottom_left_double "╚")
set(box_bottom_right_double "╝")
set(box_horizontal_double "═")
set(box_vertical_double "║")


set(box_divider_left_light "├")
set(box_divider_right_light "┤")
set(box_divider_left_heavy "┣")
set(box_divider_right_heavy "┫")
set(box_divider_left_double "╠")
set(box_divider_right_double "╣")

set(light_divider_left_light "├")
set(light_divider_right_light "┤")
set(light_divider_left_heavy "┠")
set(light_divider_right_heavy "┨")
set(light_divider_left_double "╟")
set(light_divider_right_double "╢")


set(light_line_dashed "╌")
set(light_line "─")
