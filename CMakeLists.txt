cmake_minimum_required(VERSION 3.10)
project(testParallelDirectives LANGUAGES Fortran)


# make sure OMP_NUM_THREADS is defined
if ("$ENV{OMP_NUM_THREADS}" STREQUAL "")
	message(FATAL_ERROR "Error: define OMP_NUM_THREADS")
endif()

# Figure out which compiler is being used
# This is for Cray systems
execute_process(
  COMMAND ${CMAKE_Fortran_COMPILER} --version
	OUTPUT_VARIABLE fc_version
  )
string(FIND "${fc_version}" "Cray"  is_cray)
string(FIND "${fc_version}" "Intel" is_intel)
string(FIND "${fc_version}" "GNU"   is_gnu)
string(FIND "${fc_version}" "PGI"   is_pgi)

if (is_cray GREATER -1)
	set(CMAKE_Fortran_COMPILER_ID "Cray")
elseif(is_intel GREATER -1)
	set(CMAKE_Fortran_COMPILER_ID "Intel")
elseif(is_gnu GREATER -1)
	set(CMAKE_Fortran_COMPILER_ID "GNU")
elseif(is_pgi GREATER -1)
	set(CMAKE_Fortran_COMPILER_ID "PGI")
endif()
# Fortran Compiler ID has been chosen by now

set(CMAKE_Fortran_FLAGS "-O3")

# Cray flags
if("Cray" STREQUAL ${CMAKE_Fortran_COMPILER_ID})
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
if("PGI" STREQUAL ${CMAKE_Fortran_COMPILER_ID})
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -mp")
endif()


# report the choices just to be clear
message("-- Compiler is ${CMAKE_Fortran_COMPILER_ID} with FFLAGS = \
${CMAKE_Fortran_FLAGS}")


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


# --- Functions to generate tests
function(create_test name)
	add_executable(${name} ${name}.F90)
	add_test(${prob}_${name} aprun -n 1 ./${name})
endfunction()

function(create_omp_test name)
	add_executable(${name} ${name}.F90)
	add_test(${prob}_${name} aprun -n 1 -d $ENV{OMP_NUM_THREADS} ./${name})
endfunction()

function(create_target_test name)
	add_executable(${name} ${name}.F90 )
	# target_compile_options(${name} PRIVATE -target-accel=craype-accel-nvidia60)
	add_test(${prob}_${name} aprun -n 1 ./${name})
endfunction()





# add_subdirectory(directive-tests)
message("-- WARNING: edit CMakeLists.txt to add directive-tests directory")

add_subdirectory(computation-tests)
