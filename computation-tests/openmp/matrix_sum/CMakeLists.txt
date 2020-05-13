# parallel, private, firstprivate, shared, copyin,
set(prob "matsum")
set(api  "omp")

# --- Fortran Intrinsics
gen_test(arraySyntax)
gen_test(do)
gen_test(doConcurrent1)
gen_test(doConcurrent2)

# --- OpenMP
gen_omp_test(ompParallelDo)
gen_omp_test(ompParallelLoop)
gen_omp_test(ompWorkshare)
gen_target_test(ompTarget)
gen_target_test(ompTargetDataless)

# --- OpenACC
