# parallel, private, firstprivate, shared, copyin,
set(prob "matrixsum")

# --- Fortran Intrinsics
create_test(arraySyntax)
create_test(do)
create_test(doConcurrent1)
create_test(doConcurrent2)

# --- OpenMP
create_omp_test(ompParallelDo)
create_omp_test(ompParallelLoop)
create_target_test(ompTarget)
create_target_test(ompTargetDataless)
create_target_test(ompWorkshare)

# --- OpenACC
