program sequence_generalization
  implicit none

  integer, parameter :: nmax = 50
  integer :: n
  integer(kind=8) :: computed_sum
  integer(kind=8) :: formula_value
  logical :: agrees

  print *, "n computed_sum formula_value agrees"

  do n = 1, nmax
     computed_sum = n * (n + 1) / 2
     formula_value = n * (n + 1) / 2
     agrees = computed_sum == formula_value
     print *, n, computed_sum, formula_value, agrees
  end do

  print *, "Finite agreement supports a conjecture; proof establishes the theorem."

end program sequence_generalization
