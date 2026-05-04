program recurrence_example
  implicit none

  integer, parameter :: n_terms = 20
  integer :: values(n_terms)
  integer :: i

  values(1) = 2

  do i = 2, n_terms
     values(i) = values(i - 1) + 3
  end do

  print *, "Arithmetic-like recurrence:"
  do i = 1, n_terms
     print *, i, values(i)
  end do

end program recurrence_example
