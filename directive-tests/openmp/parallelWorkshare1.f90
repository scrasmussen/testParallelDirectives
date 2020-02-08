program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 4
  integer :: i, A(n), B(n)
  B = -1
  A = 0
  !$omp parallel workshare
  A = B
  !$omp end parallel workshare
  print *, A
end program loop
