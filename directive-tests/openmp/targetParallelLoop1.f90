program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n)
  !$omp target parallel loop
  do i = 1,n
     A(i) = i
  end do
  !$omp end target parallel loop
end program loop
