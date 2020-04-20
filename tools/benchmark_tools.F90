module benchmark_tools
  implicit none
  enum, bind(C)
     enumerator :: cray_c, gnu_c, intel_c, pgi_c
  end enum
  enum, bind(C)
     enumerator :: omp_api, acc_api
  end enum
  enum, bind(C)
     enumerator :: matsum_p, saxpy_p, matmult_p
  end enum
  enum, bind(C)
     enumerator :: arraySyntax_m, do_m
     enumerator :: doConcurrent1_m, doConcurrent2_m
     enumerator :: ompParallelDo_m, ompParallelLoop_m
     enumerator :: ompTarget_m, ompTargetDataless_m, ompTargetArraySyntax_m
     enumerator :: ompWorkshare_m
  end enum
contains
  pure function compute_time(count_rate, count_init, count_fin)
    integer(kind=8), intent(IN) :: count_rate, count_init, count_fin
    double precision :: compute_time, time_init, time_fin, count_rate_d
    count_rate_d = count_rate
    time_init = count_init / count_rate_d
    time_fin  = count_fin  / count_rate_d
    compute_time = time_fin - time_init
  end function compute_time

  subroutine open_report(fint)
    integer, intent(OUT) :: fint
    character(:), allocatable :: fname
    logical :: fexists

    fname = "output.txt"
    inquire(file=fname, exist=fexists)

    fint = 2 ! this can be any number
    open(fint, file=fname,action='write',position='append')
    if (fexists .eqv. .false.) then
       write(fint,*) "n,time,method_enum,problem_enum,api_enum,compiler_enum"
    end if
  end subroutine open_report

  subroutine report(n, time, method_enum, problem_enum, api_enum, fint)
    use iso_c_binding, only: c_int
    integer(kind=8), intent(IN) :: n
    integer, intent(IN) :: fint
    double precision, intent(IN) :: time
    ! character(*), intent(IN) :: method_name
    integer(c_int) :: problem_enum, method_enum, api_enum

    write(fint,fmt="(I16,A2)", advance="no") n, ", "
    write(fint,fmt="(F30.16,A2)", advance="no") time, ", "
    write(fint,fmt="(I2,A2)", advance="no") method_enum, ", "
    write(fint,fmt="(I2,A2)", advance="no") problem_enum, ", "
    write(fint,fmt="(I2,A2)", advance="no") api_enum, ", "
    write(fint,*) COMPILER_ENUM
    ! write(fint,*) method_name
  end subroutine report

  ! subroutine open_report(problem_name, fint)
  !   character(:), allocatable, intent(IN) :: problem_name
  !   integer, intent(OUT) :: fint
  !   character(:), allocatable :: fname
  !   logical :: fexists

  !   fname = "output_" // problem_name // ".txt"
  !   inquire(file=fname, exist=fexists)

  !   fint = 2 ! this can be any number
  !   open(fint, file=fname,action='write',position='append')
  !   if (fexists .eqv. .false.) then
  !      write(fint,*) "n,time,method"
  !   end if
  ! end subroutine open_report
end module benchmark_tools
