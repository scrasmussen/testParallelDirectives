# parallel, private, firstprivate, shared, copyin,
set(prob "saxpy")
set(api  "omp")

# --- Fortran Intrinsics
gen_test(arraySyntax)
gen_test(do)
# create_test(doConcurrent1)
# create_test(doConcurrent2)

# # --- OpenMP
# create_omp_test(ompParallelDo)
# create_omp_test(ompParallelLoop)
# create_omp_test(ompWorkshare)
# create_target_test(ompTarget)
# create_target_test(ompTargetDataless)

# --- OpenACC
