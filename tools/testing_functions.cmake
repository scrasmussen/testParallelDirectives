# craype-ivybridge
# cudatoolkit
# --- Functions to generate tests ---
function(create_test name)
	add_executable(${name} ${name}.F90)
	target_link_libraries(${name} benchmark_tools)
	add_test(
		NAME ${prob}_${name}
		COMMAND aprun -n1 -N1 ./${name})
endfunction()

function(create_omp_test name)
	add_executable(${name} ${name}.F90)
	target_link_libraries(${name} benchmark_tools)
	if("Cray" STREQUAL CMAKE_Fortran_COMPILER_ID)
	  add_test(
			NAME ${prob}_${name}
	    COMMAND aprun -n1 -N1 -d $ENV{OMP_NUM_THREADS} ./${name} )
	else()
	  add_test(
			NAME ${prob}_${name}
			COMMAND ${name})
	endif()
endfunction()

function(create_target_test name)
	add_executable(${name} ${name}.F90 )
	target_link_libraries(${name} benchmark_tools)
	# target_compile_options(${name} PRIVATE -target-accel=sm_60)
	add_test(
		NAME ${prob}_${name}
		COMMAND aprun -n1 -N1 ./${name})

	# expands `make clean` to remove additional files
	set_property(
		DIRECTORY	APPEND PROPERTY
		ADDITIONAL_MAKE_CLEAN_FILES
		${CMAKE_CURRENT_BINARY_DIR}/${name}_1.ptx
		)
	set_property(
		DIRECTORY	APPEND PROPERTY
		ADDITIONAL_MAKE_CLEAN_FILES
		${CMAKE_CURRENT_BINARY_DIR}/${name}_1.cub
		)

endfunction()
