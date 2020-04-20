program matsum_arraySyntax
  use benchmark_tools
  implicit none
  double precision, dimension(:,:), allocatable :: A,B,C
  integer :: m, n, i, j, sum, max_n, step, fint
  integer(kind=8) :: count_fin, count_init, count_rate, allocate_size
  double precision :: time
  logical :: fexists

  call open_report(fint)

  n = 64
  max_n = 20000
  ! max_n = 500
  step = 2
  ! allocate(a(n),b(n,m),c(m))
  do while (n .le. max_n)

  m = n
  allocate_size = n * m
  allocate(a(n,m))
  allocate(b(n,m))
  allocate(c(n,m))

  call random_init(.true.,.false.)
  call random_number(b)
  call random_number(c)
  a = 0

  call system_clock(count_init, count_rate)
  ! do loop
  A = B + C
  call system_clock(count_fin)

  time = compute_time(count_rate, count_init, count_fin)
  call report(allocate_size, time, arraySyntax_m, omp_api, matsum_p, fint)


  deallocate(a,b,c)
  n = n * step
  end do

end program matsum_arraySyntax
