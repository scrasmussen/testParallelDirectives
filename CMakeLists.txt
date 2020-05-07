cmake_minimum_required(VERSION 3.10)
project(testParallelDirectives LANGUAGES Fortran)


# --- Figure out which compiler is being used ---
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
	set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -DCOMPILER_ENUM=cray_c")
elseif(is_intel GREATER -1)
	set(CMAKE_Fortran_COMPILER_ID "Intel")
	set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -DCOMPILER_ENUM=intel_c")
elseif(is_gnu GREATER -1)
	set(CMAKE_Fortran_COMPILER_ID "GNU")
	set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -DCOMPILER_ENUM=gnu_c")
elseif(is_pgi GREATER -1)
	set(CMAKE_Fortran_COMPILER_ID "PGI")
	set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -DCOMPILER_ENUM=pgi_c")
endif()


# --- Set Environment Variables ---
# make sure OMP_NUM_THREADS is defined
if ("$ENV{OMP_NUM_THREADS}" STREQUAL "")
	message(FATAL_ERROR "Error: define OMP_NUM_THREADS")
endif()
# set optimization
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O3")
# set debug flags
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
	set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -g")
endif()


# --- Compiler Specific Flags ---
set(CMAKE_EXEC_EXECUTABLE "")
# Cray flags
if("Cray" STREQUAL CMAKE_Fortran_COMPILER_ID)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -h omp")
  set(CMAKE_EXEC_EXECUTABLE "aprun -n 1")
endif()
# GNU flags
if("GNU" STREQUAL CMAKE_Fortran_COMPILER_ID)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -fopenmp")
  set(build_omp_target FALSE)
endif()
# Intel flags
if("Intel" STREQUAL CMAKE_Fortran_COMPILER_ID)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -qopenmp")
  set(build_omp_target FALSE PARENT_SCOPE)
endif()
# PGI flags
if("PGI" STREQUAL CMAKE_Fortran_COMPILER_ID)
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -mp")
endif()
# report the choices just to be clear
message("-- Compiler is ${CMAKE_Fortran_COMPILER_ID} with FFLAGS = \
${CMAKE_Fortran_FLAGS}")


# --- testing ---
enable_testing()

# coloring for test function
if(NOT WIN32)
  string(ASCII 27 Esc)
  set(ColourReset "${Esc}[m")
  set(Red         "${Esc}[31m")
  set(Green       "${Esc}[32m")
  set(Blue        "${Esc}[34m")
endif()


# --- Add Subdirectories ---
add_subdirectory(tools)
message("-- WARNING: edit CMakeLists.txt to add directive-tests directory")
# add_subdirectory(directive-tests)
add_subdirectory(computation-tests)
