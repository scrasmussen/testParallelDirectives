# parallel, private, firstprivate, shared, copyin,
set(prob "matrixsum")

# --- Functions to generate tests
function(create_omp_test name)
	add_executable(${name} ${name}.F90)
	add_test(${prob}_${name} aprun -n 1 -d $ENV{OMP_NUM_THREADS} ./${name})
endfunction()

function(create_target_test name)
	add_executable(${name} ${name}.F90)
	add_test(${prob}_${name} aprun -n 1 ./${name})
endfunction()


# --- Fortran Intrinsics
create_omp_test(do)
create_omp_test(doConcurrent1)
create_omp_test(doConcurrent2)

# --- OpenMP
create_omp_test(ompParallelDo)
create_omp_test(ompParallelLoop)
create_target_test(ompTarget)
create_target_test(ompTargetDataless)

# --- OpenACC
