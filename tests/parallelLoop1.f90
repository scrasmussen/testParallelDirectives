program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n)
  !$omp parallel loop
  do i = 1,n
     A(i) = i
  end do
  !$omp end parallel loop
end program loop
