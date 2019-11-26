program loop
  use omp_lib
  implicit none
  integer, parameter :: n = 10
  integer :: i,j, A(n), b(n)
  j=0
  ! $omp parallel do linear(j:1)
  do i = 1,n
     A(i) = j
     print *, "A(",i,") = ", j
  end do
  ! $omp end parallel do
  print *, A
end program loop
