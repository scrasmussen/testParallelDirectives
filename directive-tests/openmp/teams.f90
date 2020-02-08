program teams1
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n)
  !$omp teams
  do i = 1,n
     A(i) = i
  end do
  !$omp end teams
  print *, A
end program teams1
