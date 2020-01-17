cmake_minimum_required(VERSION 3.10)
project(testParallelDirectives LANGUAGES Fortran)

# GNU flags
# set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fopenmp")
# Cray flags
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -h omp ")
enable_testing()

# coloring for trycompile function
if(NOT WIN32)
  string(ASCII 27 Esc)
  set(ColourReset "${Esc}[m")
  set(Red         "${Esc}[31m")
  set(Green       "${Esc}[32m")
  set(Blue        "${Esc}[34m")
endif()

#
# Function tests if a file will compile, can show warnings, stop on fatal error
#
function(trycompile src_file path)
  get_filename_component(name ${src_file} NAME_WE)

  add_test(name ${CMAKE_Fortran_COMPILER} ${path}/${src_file})
  message("${name} is added")
  # try_compile(
  #   compiled
  #   "${CMAKE_BINARY_DIR}/temp"
  #   "${CMAKE_CURRENT_SOURCE_DIR}/${srcfile}"
  #   OUTPUT_VARIABLE output
  #   )

  # if (NOT compiled)
  #   message("${Red}${srcfile} FAILED ${ColourReset}")
  #   # message(WARNING "${output}")
  #   # message(FATAL_ERROR "${output}")
  # endif(NOT compiled)
endfunction()


add_subdirectory(tests)
