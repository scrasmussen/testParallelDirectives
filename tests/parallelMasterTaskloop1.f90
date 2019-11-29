program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n), B(n)
  !$omp parallel master taskloop
  do i = 1,n
     A(i) = B(i)
  end do
  !$omp end parallel master taskloop
end program loop
