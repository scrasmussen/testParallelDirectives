# craype-ivybridge
# cudatoolkit
set(launch aprun -n1 -N1 PARENT_SCOPE)
set(CUDA_COMPILE_PTX artless PARENT_SCOPE)
set(CUDA_PTX_COMPILATION OFF PARENT_SCOPE)


# --- Functions to generate tests ---
function(gen_test name)
	add_executable(${prob}_${name} ${prob}.F90)
	string(TOUPPER ${name} name_upper)
	target_compile_definitions(${prob}_${name} PRIVATE
	  ${name_upper}
 	  MESSAGE_m=${name}_m
	  PROBLEM_p=${prob}_p
	  API_api=${api}_api)
	target_link_libraries(${prob}_${name} benchmark_tools)
	add_test(NAME ${prob}_${name}
	  COMMAND ${launch} ./${prob}_${name})
endfunction()


function(gen_omp_test name)
	# this is for Cray only, seems best way to do checks with dif compilers
	if (${name} STREQUAL "ompParallelLoop")
		return()
	endif()

	add_executable(${prob}_${name} ${prob}.F90)
	string(TOUPPER ${name} name_upper)
	target_compile_definitions(${prob}_${name} PRIVATE
	  ${name_upper}
 	  MESSAGE_m=${name}_m
	  PROBLEM_p=${prob}_p
	  API_api=${api}_api)
	target_link_libraries(${prob}_${name} benchmark_tools)

	if("Cray" STREQUAL CMAKE_Fortran_COMPILER_ID)
	  add_test(NAME ${prob}_${name}
	    COMMAND ${launch} -d $ENV{OMP_NUM_THREADS} ./${prob}_${name} )
	else()
	  add_test(NAME ${prob}_${name}
   	    COMMAND ${prob}_${name})
	endif()
endfunction()


function(create_test name)
	add_executable(${prob}_${name} ${name}.F90)
	target_link_libraries(${prob}_${name} benchmark_tools)
	add_test(NAME ${prob}_${name}
	  COMMAND ${launch} ./${prob}_${name})
endfunction()


function(create_omp_test name)
	if (${name} STREQUAL "ompParallelLoop")
		return()
	endif()

	add_executable(${prob}_${name} ${name}.F90)
	target_link_libraries(${prob}_${name} benchmark_tools)
	if("Cray" STREQUAL CMAKE_Fortran_COMPILER_ID)
	  add_test(NAME ${prob}_${name}
	    COMMAND ${launch} -d $ENV{OMP_NUM_THREADS} ./${prob}_${name} )
	else()
	  add_test(NAME ${prob}_${name}
   	    COMMAND ${prob}_${name})
	endif()
endfunction()


function(gen_target_test name)
  # Copy file to binary so the outputted PTX will have unique names
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/${prob}.F90
    ${CMAKE_CURRENT_BINARY_DIR}/${name}.F90
    COPYONLY)

  add_executable(${prob}_${name} ${CMAKE_CURRENT_BINARY_DIR}/${name}.F90)
  string(TOUPPER ${name} name_upper)
  target_compile_definitions(${prob}_${name} PRIVATE
    ${name_upper}
    MESSAGE_m=${name}_m
    PROBLEM_p=${prob}_p
    API_api=${api}_api)
  target_link_libraries(${prob}_${name} benchmark_tools)
  target_compile_options(${prob}_${name} PRIVATE -target-accel=nvidia60)
  # target_compile_options(${prob}_${name} PRIVATE -target-accel=sm_60) # !work

  add_test(NAME ${prob}_${name}
    COMMAND ${launch} ./${prob}_${name})
  # expands `make clean` to remove additional files
  set_property(DIRECTORY APPEND PROPERTY
    ADDITIONAL_MAKE_CLEAN_FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${name}_1.ptx)
  set_property(DIRECTORY APPEND PROPERTY
    ADDITIONAL_MAKE_CLEAN_FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${name}_1.cub)
endfunction()


function(create_target_test name)
	add_executable(${prob}_${name} ${name}.F90 )
	string(TOUPPER ${name} name_upper)
	target_compile_definitions(${prob}_${name} PRIVATE
 	  MESSAGE_m=${name}_m
	  PROBLEM_p=${prob}_p
	  API_api=${api}_api)
	target_link_libraries(${prob}_${name} benchmark_tools)
	target_compile_options(${prob}_${name} PRIVATE -target-accel=nvidia60)
	# target_compile_options(${name} PRIVATE -target-accel=sm_60)
	add_test(NAME ${prob}_${name}
	  COMMAND ${launch} ./${prob}_${name})

	# expands `make clean` to remove additional files
	set_property(DIRECTORY APPEND PROPERTY
	  ADDITIONAL_MAKE_CLEAN_FILES
	  ${CMAKE_CURRENT_BINARY_DIR}/${name}_1.ptx)
	set_property(DIRECTORY APPEND PROPERTY
	  ADDITIONAL_MAKE_CLEAN_FILES
	  ${CMAKE_CURRENT_BINARY_DIR}/${name}_1.cub)
endfunction()
