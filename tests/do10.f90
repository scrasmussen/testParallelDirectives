program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i,j, A(n,n), sum(n)
  sum = 0
  !$omp do reduction(+:sum)
  do i = 1,n
     sum(n) = i
  end do
  !$omp end do
  print*, sum
end program loop
