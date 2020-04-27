# parallel, private, firstprivate, shared, copyin,
set(prob "saxpy")
set(api  "omp")

# # --- Fortran Intrinsics
# gen_test(arraySyntax)
# gen_test(do)
# gen_test(doConcurrent1)

# # # --- OpenMP
# gen_omp_test(ompParallelDo)
# gen_omp_test(ompParallelLoop)
# gen_omp_test(ompWorkshare)
gen_target_test(ompTarget) # WORKS
gen_target_test(ompTargetDataless)


# -- instead of --
# gen_omp_test(ompParallelDo)
# gen_omp_test(ompParallelLoop)
# gen_omp_test(ompWorkshare)
# gen_target_test(ompTarget)
# gen_target_test(ompTargetDataless)

# --- OpenACC
