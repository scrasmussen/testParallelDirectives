program matvec_doloop
  implicit none
  double precision, dimension(:),  allocatable :: a, c
  double precision, dimension(:,:), allocatable :: B
  integer :: m, n, i, j, sum, max_n, step
  integer(kind=8) :: count_fin, count_init, count_rate
  double precision :: time_fin, time_init, count_rate_d
  character(:), allocatable :: fname, arg1
  logical :: fexists
  fname = "output.txt"
  inquire(file=fname, exist=fexists)
  open(2, file=fname,action='write',access='append')
  if (fexists .eq. .false.) then
    write(2,*) "method,    n,    time"
  end if

  call random_seed()

  max_n = 150000
  n = 10000
  step = 10000

  ! allocate(a(n),b(n,m),c(m))
  do while (n .le. max_n)

  m = n
  allocate(a(n))
  allocate(b(n,m))
  allocate(c(n))

  call random_number(b)
  call random_number(c)
  a = 0

  call system_clock(count_init, count_rate)
  ! do loop
  do j=1,n
    do i=1,m
      a(j) = a(j) + B(i,j) * c(i)
    end do
  end do
  call system_clock(count_fin)

  count_rate_d = count_rate
  time_init = count_init / count_rate_d
  time_fin  = count_fin  / count_rate_d
  ! print *, "column major time:", time_fin - time_init
  write(2,fmt="(I8,A2)", advance="no") n, ", "
  write(2,fmt="(F20.6,A2,I1)") time_fin - time_init, ", ", 2

  deallocate(a,b,c)
  n = n + step
  end do

end program matvec_doloop
