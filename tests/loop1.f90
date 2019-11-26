program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i, A(n)
  !$omp loop
  do i = 1,n
     A(i) = i
  end do
  !$omp end loop
  print *, A
end program loop
