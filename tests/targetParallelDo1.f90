program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n)
  !$omp target parallel do
  do i = 1,n
     A(i) = i
  end do
  !$omp end target parallel do
end program loop
