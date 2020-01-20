# parallel, private, firstprivate, shared, copyin,
# message("${CMAKE_Fortran_COMPILER} ${CMAKE_Fortran_FLAGS}  ${CMAKE_CURRENT_SOURCE_DIR}/parallel1.f90")
set(fopt ${CMAKE_Fortran_FLAGS})
separate_arguments(fopt)


add_executable(do_loop doloop.F90)
add_test(matrix_sum_do_loop aprun -n 16 ./do_loop)

add_executable(do_concurrent1 doconcurrent1.F90)
add_test(matrix_sum_do_concurrent1 aprun -n 16 ./do_concurrent1)

add_executable(do_concurrent2 doconcurrent2.F90)
add_test(matrix_sum_do_concurrent2 aprun -n 16 ./do_concurrent2)

add_executable(omp_parallel_do omp.F90)
add_test(matrix_sum_omp_parallel_do aprun -n 16 ./omp_parallel_do)
