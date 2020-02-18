program matvec_doloop
  use benchmark_tools
  implicit none
  double precision, dimension(:,:), allocatable :: A,B,C
  integer :: m, n, i, j, sum, max_n, step, fint
  integer(kind=8) :: count_fin, count_init, count_rate
  double precision :: time_fin, time_init, count_rate_d
  character(:), allocatable :: arg1, prob
  logical :: fexists

  prob = "matrix_sum"
  call open_report(prob, fint)

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
  do j=1,n
    do i=1,m
      A(i,j) = B(i,j) + C(i,j)
    end do
  end do
  call system_clock(count_fin)

  count_rate_d = count_rate
  time_init = count_init / count_rate_d
  time_fin  = count_fin  / count_rate_d
  ! print *, "column major time:", time_fin - time_init
  call report(n,time_fin - time_init, "do", fint)


  deallocate(a,b,c)
  n = n * step
  end do

end program matvec_doloop
