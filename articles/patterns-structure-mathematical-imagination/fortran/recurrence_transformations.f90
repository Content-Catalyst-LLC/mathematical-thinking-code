program recurrence_transformations
  implicit none

  integer, parameter :: n = 20
  integer :: i
  integer(kind=8), dimension(n) :: odd_squares
  integer(kind=8), dimension(n) :: triangular
  integer(kind=8), dimension(n) :: powers_two

  do i = 1, n
     odd_squares(i) = i * i
     triangular(i) = i * (i + 1) / 2
     powers_two(i) = 2 ** (i - 1)
  end do

  print *, "index square triangular powers_two first_difference_square"
  do i = 1, n
     if (i == 1) then
        print *, i, odd_squares(i), triangular(i), powers_two(i), 0
     else
        print *, i, odd_squares(i), triangular(i), powers_two(i), odd_squares(i) - odd_squares(i - 1)
     end if
  end do

end program recurrence_transformations
