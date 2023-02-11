

include(${CMAKE_CURRENT_SOURCE_DIR}/LoggingUtils/colorCodes.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/LoggingUtils/stringUtils.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/LoggingUtils/boxDrawing.cmake)

function(print_logging_status)
  set(trace_color "${white}")
  set(debug_color "${blue}")
  set(info_color  "${green}")
  set(warn_color  "${yellow}")
  set(error_color "${red}")
  set(dev_color   "${magenta}")

  if(${marsLogging_global_enable})
    set(enable_color ${boldGreen})
  else()
    set(enable_color ${boldRed})
  endif()

  string(CONCAT log_global_enable_msg "global_enable: ${enable_color}"
      "${marsLogging_global_enable}${colorReset}")
  string(CONCAT log_global_lvl_msg "global_level: ${colorBold}"
      "${${marsLogging_global_level}_color}${marsLogging_global_level}${colorReset}")


  set(box_width 50)
  set(box_variant heavy)

  print_box_top(${box_width} ${box_variant})
  print_box_text(${colorBold}marsLogging${colorReset} ${box_width} ${box_variant})
  print_box_vertical_divider(${box_width} ${box_variant} LIGHT)
  print_box_text(${log_global_enable_msg} ${box_width} ${box_variant})
  print_box_text(${log_global_lvl_msg} ${box_width} ${box_variant})
  print_box_vertical_divider(${box_width} ${box_variant} DASHED)
  print_box_bottom(${box_width} ${box_variant})

endfunction()
