# --- Functions to generate tests ---
function(create_test name)
	add_executable(${name} ${name}.F90)
	target_link_libraries(${name} benchmark_tools)
	add_test(${prob}_${name} CMAKE_EXEC_EXECUTABLE ./${name})
endfunction()

function(create_omp_test name)
	add_executable(${name} ${name}.F90)
	target_link_libraries(${name} benchmark_tools)
	if("Cray" STREQUAL CMAKE_Fortran_COMPILER_ID)
	  add_test(${prob}_${name} CMAKE_EXEC_EXECUTABLE -d
	    $ENV{OMP_NUM_THREADS} ./${name})
	else()
	  add_test(${prob}_${name} CMAKE_EXEC_EXECUTABLE ./${name})
	endif()
endfunction()

function(create_target_test name)
	add_executable(${name} ${name}.F90 )
	target_link_libraries(${name} benchmark_tools)
	# target_compile_options(${name} PRIVATE -target-accel=craype-accel-nvidia60)
	add_test(${prob}_${name} CMAKE_EXEC_EXECUTABLE ./${name})
endfunction()
