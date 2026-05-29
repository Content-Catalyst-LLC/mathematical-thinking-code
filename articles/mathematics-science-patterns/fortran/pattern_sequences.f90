program pattern_sequences
  implicit none

  integer, parameter :: n = 20
  integer :: i
  integer(kind=8), dimension(n) :: arithmetic
  integer(kind=8), dimension(n) :: squares
  integer(kind=8), dimension(n) :: fibonacci

  do i = 1, n
     arithmetic(i) = 2 + 3 * (i - 1)
     squares(i) = i * i
  end do

  fibonacci(1) = 0
  fibonacci(2) = 1
  do i = 3, n
     fibonacci(i) = fibonacci(i - 1) + fibonacci(i - 2)
  end do

  print *, "index arithmetic squares fibonacci first_difference_squares"
  do i = 1, n
     if (i == 1) then
        print *, i - 1, arithmetic(i), squares(i), fibonacci(i), 0
     else
        print *, i - 1, arithmetic(i), squares(i), fibonacci(i), squares(i) - squares(i - 1)
     end if
  end do

  print *, "Finite pattern tables support conjecture; proof establishes generality."

end program pattern_sequences
