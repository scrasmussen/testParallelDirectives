program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n), b
  b = 2
  !$omp parallel firstprivate(b)
  do i = 1,n
     A(i) = b
  end do
  !$omp end parallel
end program loop
