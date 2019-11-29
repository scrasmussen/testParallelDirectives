program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n)
  i = 0
  call omp_set_num_threads(2)
  !$omp parallel
  !$omp single
  !$omp task shared(i) depend(out:i)
  i = omp_get_thread_num()
  !$omp end task

  !$omp task shared(i) depend(in:i)
  print *, i
  !$omp end task


  !$omp end single
  !$omp end parallel

end program loop
