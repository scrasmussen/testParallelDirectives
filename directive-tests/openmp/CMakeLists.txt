# parallel, private, firstprivate, shared, copyin,
# message("${CMAKE_Fortran_COMPILER} ${CMAKE_Fortran_FLAGS}  ${CMAKE_CURRENT_SOURCE_DIR}/parallel1.f90")
set(fopt ${CMAKE_Fortran_FLAGS})
separate_arguments(fopt)

add_test(${CMAKE_Fortran_COMPILER} echo)
add_test(parallel1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallel1.f90)
add_test(parallel2 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallel2.f90)
add_test(parallel3 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallel3.f90)
add_test(parallel4 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallel4.f90)

# # do
add_test(do1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/do1.f90)
add_test(do2 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/do2.f90)
# add_test(do3 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/do3.f90)
# add_test(do4 ${CMAKE_Fortran_COMPILER} ${CMAKE_CURRENT_SOURCE_DIR}/do4.f90)
add_test(do5 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/do5.f90)
add_test(do6 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/do6.f90)
add_test(do7 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/do7.f90)
add_test(do8 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/do8.f90)

# # parallel do
add_test(parallelDo1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallelDo1.f90)
add_test(parallelDo2 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallelDo2.f90)
add_test(parallelDo3 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallelDo3.f90)
add_test(parallelDo4 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallelDo4.f90)
add_test(parallelDoSIMD1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallelDoSIMD1.f90)

# target
add_test(targetParallelDo1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/targetParallelDo1.f90)
add_test(targetParallelLoop1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/targetParallelLoop1.f90)
add_test(targetTeamsDistribute1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}//
  targetTeamsDistribute1.f90)
add_test(targetTeamsDistributeSIMD1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}//
  targetTeamsDistributeSIMD1.f90)

# teams
add_test(teams ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/teams.f90)

# loop
add_test(loop1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/loop1.f90)
add_test(parallelLoop1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallelLoop1.f90)

# master
# add_test(parallelMasterTaskloop1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}//
#   parallelMasterTaskloop1.f90)

# sections
add_test(parallelSections1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallelSections1.f90)

# workshare
add_test(parallelWorkshare1 ${CMAKE_Fortran_COMPILER} ${fopt} ${CMAKE_CURRENT_SOURCE_DIR}/parallelWorkshare1.f90)
