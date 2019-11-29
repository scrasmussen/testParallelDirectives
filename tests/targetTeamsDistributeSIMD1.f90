program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n)
  !$omp target teams distribute parallel do SIMD
  do i = 1,n
     A(i) = i
  end do
  !$omp end target teams distribute parallel do SIMD
end program loop
