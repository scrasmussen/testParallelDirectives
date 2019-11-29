# parallel, private, firstprivate, shared, copyin,
trycompile(parallel1.f90)
trycompile(parallel2.f90)
trycompile(parallel3.f90)
trycompile(parallel4.f90)

# do
trycompile(do1.f90)
trycompile(do2.f90)
# trycompile(do3.f90)
# trycompile(do4.f90)
trycompile(do5.f90)
trycompile(do6.f90)
trycompile(do7.f90)
trycompile(do8.f90)
trycompile(do9.f90)

# parallel do
trycompile(parallelDo1.f90)
trycompile(parallelDo2.f90)
trycompile(parallelDo3.f90)
trycompile(parallelDo4.f90)
trycompile(parallelDoSIMD1.f90)

# target
trycompile(targetParallelDo1.f90)
trycompile(targetParallelLoop1.f90)
trycompile(targetTeamsDistribute1.f90)
trycompile(targetTeamsDistributeSIMD1.f90)

# teams
trycompile(teams.f90)

# loop
trycompile(loop1.f90)
trycompile(parallelLoop1.f90)

# master
trycompile(parallelMasterTaskloop1.f90)

# sections
trycompile(parallelSections1.f90)

# workshare
trycompile(parallelWorkshare1.f90)
