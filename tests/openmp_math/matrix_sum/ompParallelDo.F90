program matvec_doloop
  implicit none
  double precision, dimension(:,:), allocatable :: A,B,C
  integer :: m, n, i, j, sum, max_n, step
  integer(kind=8) :: count_fin, count_init, count_rate
  double precision :: time_fin, time_init, count_rate_d
  character(:), allocatable :: fname, arg1
  logical :: fexists
  fname = "output_matsum.txt"
  inquire(file=fname, exist=fexists)
  open(2, file=fname,action='write',position='append')
  if (fexists .eqv. .false.) then
    ! open(2, file=fname,action='write')
    write(2,*) "n,    time,     method"
  else

  end if


  n = 64
  max_n = 20000
  ! max_n = 500
  step = 2
  ! allocate(a(n),b(n,m),c(m))
  do while (n .le. max_n)

  m = n
  allocate(a(n,m))
  allocate(b(n,m))
  allocate(c(n,m))

  call random_init(.true.,.false.)
  call random_number(b)
  call random_number(c)
  a = 0

  call system_clock(count_init, count_rate)
  ! do loop
  !$omp parallel do
  do j=1,n
    do i=1,m
      A(i,j) = B(i,j) + C(i,j)
    end do
   end do
  !$omp end parallel do
  call system_clock(count_fin)

  count_rate_d = count_rate
  time_init = count_init / count_rate_d
  time_fin  = count_fin  / count_rate_d
  ! print *, "column major time:", time_fin - time_init
  write(2,fmt="(I8,A2)", advance="no") n, ", "
  write(2,fmt="(F20.6,A2)", advance="no") time_fin - time_init, ", "
  write(2,fmt="(A13)") "ompparalleldo"

  deallocate(a,b,c)
  n = n * step
  end do

end program matvec_doloop
