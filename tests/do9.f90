program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i,j, A(n,n)
  !$omp do ordered(2)
  do j = 1,n
     do i = 1,n
        A(i,j) = ((j-1)*n + i
     end do
  end do
  !$omp end do
end program loop
