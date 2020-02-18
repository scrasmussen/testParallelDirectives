module benchmark_tools
  implicit none
contains
  subroutine open_report(problem_name, fint)
    character(:), allocatable, intent(IN) :: problem_name
    integer, intent(OUT) :: fint
    character(:), allocatable :: fname
    logical :: fexists

    fname = "output_" // problem_name // ".txt"
    inquire(file=fname, exist=fexists)

    fint = 2 ! this can be any number
    open(fint, file=fname,action='write',position='append')
    if (fexists .eqv. .false.) then
       write(fint,*) "n,time,method"
    end if
  end subroutine open_report


  subroutine report(n, time, method_name, fint)
    integer, intent(IN) :: n, fint
    double precision, intent(IN) :: time
    character(*), intent(IN) :: method_name

    write(fint,fmt="(I8,A2)", advance="no") n, ", "
    write(fint,fmt="(F20.6,A2)", advance="no") time, ", "
    write(fint,*) method_name
  end subroutine report
end module benchmark_tools
