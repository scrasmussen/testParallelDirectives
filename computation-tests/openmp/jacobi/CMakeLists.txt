# parallel, private, firstprivate, shared, copyin,
# set(fopt ${CMAKE_Fortran_FLAGS})
# separate_arguments(fopt)

# --- Fortran Intrinsics
add_executable(do_loop doloop.F90)
add_test(matrix_sum_do_loop aprun -n 16 ./do_loop)

# add_executable(do_concurrent1 doconcurrent1.F90)
# add_test(matrix_sum_do_concurrent1 aprun -n 16 ./do_concurrent1)

# add_executable(do_concurrent2 doconcurrent2.F90)
# add_test(matrix_sum_do_concurrent2 aprun -n 16 ./do_concurrent2)

# # --- OpenMP
# add_executable(omp_parallel_do omp_parallel_do.F90)
# add_test(matrix_sum_omp_parallel_do aprun -n 16 ./omp_parallel_do)

# # add_executable(omp_parallel_loop omp_parallel_loop.F90)
# # add_test(matrix_sum_omp_parallel_loop aprun -n 1 ./omp_parallel_loop)

# add_executable(omp_target_parallel_do omp_target.F90)
# add_test(matrix_sum_omp_target_parallel_do aprun -n 1 ./omp_target_parallel_do)

# add_executable(omp_target_parallel_do_dataless omp_target_dataless.F90)
# add_test(matrix_sum_omp_target_parallel_do_dataless aprun -n 1 ./omp_target_parallel_do_dataless)

# # --- OpenACC
