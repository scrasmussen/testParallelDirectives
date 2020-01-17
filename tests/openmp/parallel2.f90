program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n), b
  !$omp parallel private(b)
  do i = 1,n
     b = i
     A(i) = b
  end do
  !$omp end parallel
end program loop
