program matsum_doloop
  use benchmark_tools
  implicit none
  double precision, dimension(:,:), allocatable :: A_output,B_input,C_input
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
  allocate(a_output(n,m))
  allocate(b_input(n,m))
  allocate(c_input(n,m))

  call random_init(.true.,.false.)
  call random_number(b_input)
  call random_number(c_input)
  a_output = 0

  !$omp target enter data map(to:B_input,C_input)

  call system_clock(count_init, count_rate)
  ! do loop
  !$omp target teams distribute parallel do collapse(2)
  do j=1,n
    do i=1,m
      A_output(i,j) = B_input(i,j) + C_input(i,j)
    end do
  end do
  !$omp end target teams distribute parallel do
  call system_clock(count_fin)
  !$omp target exit data map(from:A_output)

  time = compute_time(count_rate, count_init, count_fin)
  call report(allocate_size, time, ompTargetDataless_m, omp_api, matsum_p, fint)

  deallocate(a_output,b_input,c_input)
  n = n * step
  end do

end program matsum_doloop
