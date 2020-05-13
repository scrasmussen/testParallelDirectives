program matsum_do
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

#ifdef OMPTARGETDATALESS
  !$omp target enter data map(to:B_input,C_input)
#endif

  call system_clock(count_init, count_rate)

#ifdef ARRAYSYNTAX
  A = B + C
#endif

#ifdef DO
  do j=1,n
    do i=1,m
      A(i,j) = B(i,j) + C(i,j)
    end do
  end do
#endif

#ifdef DOCONCURRENT1
  do concurrent (i=1:m, j=1:n)
      A(i,j) = B(i,j) + C(i,j)
  end do
#endif

#ifdef DOCONCURRENT2
  do concurrent (j=1:n, i=1:m)
      A(i,j) = B(i,j) + C(i,j)
  end do
#endif

#ifdef OMPPARALLELDO
  !$omp parallel do
  do j=1,n
    do i=1,m
      A(i,j) = B(i,j) + C(i,j)
    end do
   end do
  !$omp end parallel do
#endif

#ifdef OMPPARALLELLOOP
  !$omp parallel loop
  do j=1,n
    do i=1,m
      A(i,j) = B(i,j) + C(i,j)
    end do
   end do
  !$omp end parallel loop
#endif

#ifdef OMPWORKSHARE
  !$omp parallel workshare
  A = B + C
  !$omp end parallel workshare
#endif

#ifdef OMPTARGET
  !$omp target teams distribute parallel do collapse(2)
  do j=1,n
    do i=1,m
      A(i,j) = B(i,j) + C(i,j)
    end do
   end do
  !$omp end target teams distribute parallel do
#endif

#ifdef OMPTARGETDATALESS
  !$omp target teams distribute parallel do collapse(2)
  do j=1,n
    do i=1,m
      A_output(i,j) = B_input(i,j) + C_input(i,j)
    end do
  end do
  !$omp end target teams distribute parallel do
#endif

! ---- Stop the timer ----
  call system_clock(count_fin)
#ifdef OMPTARGETDATALESS
  !$omp target exit data map(from:A_output)
#endif

  time = compute_time(count_rate, count_init, count_fin)
  call report(allocate_size, time, do_m, omp_api, matsum_p, fint)


  deallocate(a,b,c)
  n = n * step
  end do

end program matsum_do
