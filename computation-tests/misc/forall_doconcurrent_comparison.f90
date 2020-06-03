program forall_doconcurrent_test
  implicit none
  integer, parameter :: n=16
  integer :: A(n), i

  do i=1,n
     A(i) = i
  end do
  print *, "-----ORIGINAL--------"
  print *, A


  forall (i=2:n)
     A(i) = A(i-1)
  end forall
  print *, "-----FOR ALL------"
  print *, A

  do i=2,n
     A(i) = i
  end do

  do concurrent (i=2:n)
     A(i) = A(i-1)
  end do

  print *, "--DO CONCURRENT--"
  print *, A
  print *, "Fin"

end program forall_doconcurrent_test
