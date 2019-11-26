program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n), b
  !$omp do schedule(simd, guided)
  do i = 1,n
     b = i
     A(i) = b
  end do
  !$omp end do
end program loop
