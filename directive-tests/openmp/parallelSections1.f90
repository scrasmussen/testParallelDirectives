program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 4
  integer :: i, A(n,n)
  A = 0
  !$omp parallel sections
  !$omp section
  A(:,1) = 1
  !$omp section
  A(1,:) = -1
  !$omp end parallel sections
  print *, A
end program loop
