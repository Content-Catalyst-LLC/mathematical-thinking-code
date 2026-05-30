program polynomial_notation_demo
  implicit none

  integer :: x
  integer :: expanded
  integer :: factored

  print *, 'x expanded factored holds'
  do x = -10, 10
     expanded = x*x + 2*x + 1
     factored = (x + 1) * (x + 1)
     print *, x, expanded, factored, expanded == factored
  end do

  print *, 'Interpretation: finite checks illustrate but do not replace symbolic proof.'

end program polynomial_notation_demo
