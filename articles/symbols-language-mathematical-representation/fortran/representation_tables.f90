program representation_tables
  implicit none

  integer, parameter :: n = 11
  integer :: i
  integer :: x
  integer :: f_value
  integer :: g_value

  print *, "x f_x_squared g_abs_x_squared agree interpretation"

  do i = 1, n
     x = i - 6
     f_value = x * x
     g_value = abs(x) * abs(x)
     print *, x, f_value, g_value, f_value == g_value, "finite table not full proof"
  end do

  print *, "Sampled function representations support comparison; proof establishes domain-wide equality."

end program representation_tables
