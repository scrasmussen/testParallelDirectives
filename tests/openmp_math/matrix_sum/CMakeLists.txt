# parallel, private, firstprivate, shared, copyin,
# message("${CMAKE_Fortran_COMPILER} ${CMAKE_Fortran_FLAGS}  ${CMAKE_CURRENT_SOURCE_DIR}/parallel1.f90")
set(fopt ${CMAKE_Fortran_FLAGS})
separate_arguments(fopt)

set(prob "matrixsum")

function(set_aprun_omp exe)
	set(aprun_command "aprun -n 1 -d $ENV{OMP_NUM_THREADS} ./${exe}" PARENT_SCOPE)
endfunction()

function(create_omp_test name)
	add_executable(${name} ${name}.F90)
	add_test(${prob}_${name} aprun -n 1 -d $ENV{OMP_NUM_THREADS} ./${name})
endfunction()

function(create_target_test name)
	add_executable(${name} ${name}.F90)
	add_test(${prob}_${name} aprun -n 1 ./${name})
endfunction()

# --- Fortran Intrinsics
create_omp_test(doloop)
create_omp_test(doconcurrent1)
create_omp_test(doconcurrent2)

# --- OpenMP
create_omp_test(omp_parallel_do)
create_omp_test(omp_parallel_loop)
# create_target_test(omp_target)
# create_target_test(omp_target_dataless)

# --- OpenACC
