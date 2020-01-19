cmake_minimum_required(VERSION 3.10)
project(testParallelDirectives LANGUAGES Fortran)



# execute_process(COMMAND "${CMAKE_Fortran_COMPILER} --version"
# 							  RESULT_VARIABLE r1
# 							  RESULTS_VARIABLE r2
# 							  OUTPUT_VARIABLE ov
# 							  ERROR_VARIABLE ev)

# #							  OUTPUT_VARIABLE lc)

# message("results are ${r1} and ${r2}.")
# message("outputs are ${ov} and ${ev}.")
# message("compiler is ${CMAKE_Fortran_COMPILER}")
# message("compiler is ${CMAKE_Fortran_COMPILER_ID}")

# SETTING CURRENT ENVIRONMENT
set(LC "ifort")
message("===working with ${LC}===")

set(CMAKE_Fortran_COMPILER_ID "Cray")
# set(CMAKE_Fortran_COMPILER_ID "GNU")
# set(CMAKE_Fortran_COMPILER_ID "PGI")
set(CMAKE_Fortran_COMPILER_ID "Intel")
message("CMAKE_Fortran_COMPILER_ID = ${CMAKE_Fortran_COMPILER_ID}")


# Cray flags
if("Cray" STREQUAL)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -h omp")
endif()
# GNU flags
if("GNU" STREQUAL ${CMAKE_Fortran_COMPILER_ID})
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fopenmp")
endif()
# Intel flags
if("Intel" STREQUAL ${CMAKE_Fortran_COMPILER_ID})
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -qopenmp")
endif()
# PGI flags
if("PGI" STREQUAL)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -mp")
endif()




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
