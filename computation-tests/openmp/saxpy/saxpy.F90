program matsum_do
  use benchmark_tools
  implicit none
  real, dimension(:), allocatable :: z,x,y
  real :: alpha
  integer :: n, i, j, max_n, step, fint, message
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

  allocate_size = n*n*2 ! multiplying by n because other problems are arrays and
                        ! multiplying by 2 because others are double precision
  allocate(z(allocate_size))
  allocate(x(allocate_size))
  allocate(y(allocate_size))

  call random_init(.true.,.false.)
  call random_number(x)
  call random_number(y)
  call random_number(alpha)
  z = 0

#ifdef OMPTARGETDATALESS
  !$omp target enter data map(to:alpha,to:x,to:y)
#endif

  call system_clock(count_init, count_rate)

#ifdef ARRAYSYNTAX
  z = alpha * x + y
#endif

#ifdef DO
  do i=1,n
     z(i) = alpha * x(i) + y(i)
  end do
#endif

#ifdef DOCONCURRENT1
  do concurrent (i=1:n)
     z(i) = alpha * x(i) + y(i)
  end do
#endif

#ifdef OMPPARALLELDO
  !$omp parallel do
  do i=1,n
     z(i) = alpha * x(i) + y(i)
  end do
  !$omp end parallel do
#endif

#ifdef OMPPARALLELLOOP
  !$omp parallel loop
  do i=1,n
     z(i) = alpha * x(i) + y(i)
  end do
  !$omp end parallel loop
#endif

#ifdef OMPWORKSHARE
  !$omp parallel workshare
  z = alpha * x + y
  !$omp end parallel workshare
#endif

#ifdef OMPTARGET
  !$omp target teams distribute parallel do collapse(1)
  do i=1,n
     z(i) = alpha * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do
#endif

#ifdef OMPTARGETDATALESS
  !$omp target teams distribute parallel do collapse(1)
  do i=1,n
     z(i) = alpha * x(i) + y(i)
  end do
  !$omp end target teams distribute parallel do
#endif

! ---- Stop the timer ----
  call system_clock(count_fin)

#ifdef OMPTARGETDATALESS
  !$omp target exit data map(from:z)
#endif

  time = compute_time(count_rate, count_init, count_fin)
  call report(allocate_size, time, MESSAGE_m, API_api, PROBLEM_p, fint)

  deallocate(z,x,y)
  n = n * step
  end do

end program matsum_do
