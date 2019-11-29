program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n), b
  b = -1
  !$omp parallel do firstprivate(b)
  do i = 1,n
     A(i) = b
     b = i
  end do
  !$omp end parallel do
  b=3
end program loop
