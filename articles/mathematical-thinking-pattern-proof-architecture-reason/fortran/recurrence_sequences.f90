program recurrence_sequences
  implicit none

  integer, parameter :: n = 30
  integer :: i
  integer(kind=8), dimension(n) :: fib
  integer(kind=8), dimension(n) :: pell

  fib(1) = 0
  fib(2) = 1

  pell(1) = 0
  pell(2) = 1

  do i = 3, n
     fib(i) = fib(i - 1) + fib(i - 2)
     pell(i) = 2 * pell(i - 1) + pell(i - 2)
  end do

  print *, "index fibonacci pell"
  do i = 1, n
     print *, i - 1, fib(i), pell(i)
  end do

end program recurrence_sequences
