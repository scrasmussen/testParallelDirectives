# parallel, private, firstprivate, shared, copyin,
set(prob "saxpy")

# --- Fortran Intrinsics
create_test(do)
# create_test(doConcurrent1)
# create_test(doConcurrent2)

# # --- OpenMP
# create_omp_test(ompParallelDo)
# create_omp_test(ompParallelLoop)
# create_omp_test(ompWorkshare)
# create_target_test(ompTarget)
# create_target_test(ompTargetDataless)

# --- OpenACC
